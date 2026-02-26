#!/usr/bin/env node
import {
  intro,
  outro,
  select,
  confirm,
  spinner,
  note,
  cancel,
  isCancel,
} from '@clack/prompts';
import { existsSync, mkdirSync, copyFileSync, readdirSync, statSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';
import pc from 'picocolors';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// When published to npm, framework files live in installer/template/
// When running locally from source, they live in the parent repo root (../../)
const templateDir = join(__dirname, '../template');
const frameworkRoot = existsSync(templateDir)
  ? templateDir
  : join(__dirname, '../../');

function copyDir(src: string, dest: string) {
  if (!existsSync(src)) return;
  mkdirSync(dest, { recursive: true });
  for (const entry of readdirSync(src)) {
    const srcPath = join(src, entry);
    const destPath = join(dest, entry);
    if (statSync(srcPath).isDirectory()) {
      copyDir(srcPath, destPath);
    } else {
      copyFileSync(srcPath, destPath);
    }
  }
}

async function main() {
  console.log('\n');
  intro(pc.bgMagenta(pc.white('  BurnProof-AgentFlow Installer ⚡  ')));

  const targetDir = process.argv[2]
    ? join(process.cwd(), process.argv[2])
    : process.cwd();

  note(pc.cyan(targetDir), 'Installing into');

  // Warn if already installed
  if (existsSync(join(targetDir, 'agents'))) {
    const overwrite = await confirm({
      message: 'BurnProof-AgentFlow files already exist here. Overwrite?',
      initialValue: false,
    });
    if (isCancel(overwrite) || !overwrite) {
      cancel('Installation cancelled.');
      process.exit(0);
    }
  }

  // Editor selection
  const editor = await select({
    message: 'Which editor are you using?',
    options: [
      {
        value: 'claude-code',
        label: 'Claude Code',
        hint: 'Adds /rex and /new-story commands',
      },
      {
        value: 'cursor',
        label: 'Cursor',
        hint: 'Adds @rex and @new-story rules',
      },
      {
        value: 'both',
        label: 'Both',
        hint: 'Claude Code + Cursor',
      },
      {
        value: 'none',
        label: "Skip — I'll set it up manually",
        hint: 'See adapters/ for instructions',
      },
    ],
  });

  if (isCancel(editor)) {
    cancel('Installation cancelled.');
    process.exit(0);
  }

  const s = spinner();
  s.start('Installing...');

  try {
    // Core framework directories
    copyDir(join(frameworkRoot, 'agents'), join(targetDir, 'agents'));
    s.message('Copying agent files...');

    copyDir(join(frameworkRoot, 'templates'), join(targetDir, 'templates'));
    s.message('Copying templates...');

    copyDir(join(frameworkRoot, 'intake'), join(targetDir, 'intake'));
    s.message('Copying intake folder...');

    // WORKFLOW.md
    const workflowSrc = join(frameworkRoot, 'WORKFLOW.md');
    if (existsSync(workflowSrc)) {
      copyFileSync(workflowSrc, join(targetDir, 'WORKFLOW.md'));
    }
    s.message('Copying WORKFLOW.md...');

    // Create required project directories (empty, for generated files)
    for (const dir of [
      'specs/epics',
      'specs/stories',
      'specs/contracts',
      'docs/intake',
      'docs/api',
      'config',
    ]) {
      mkdirSync(join(targetDir, dir), { recursive: true });
    }
    s.message('Creating project directories...');

    // Editor adapters
    if (editor === 'claude-code' || editor === 'both') {
      mkdirSync(join(targetDir, '.claude/commands'), { recursive: true });
      copyDir(
        join(frameworkRoot, 'adapters/claude-code'),
        join(targetDir, '.claude/commands')
      );
      s.message('Setting up Claude Code adapter...');
    }

    if (editor === 'cursor' || editor === 'both') {
      mkdirSync(join(targetDir, '.cursor/rules'), { recursive: true });
      copyDir(
        join(frameworkRoot, 'adapters/cursor'),
        join(targetDir, '.cursor/rules')
      );
      s.message('Setting up Cursor adapter...');
    }

    s.stop(pc.green('Installation complete ⚡'));
  } catch (err) {
    s.stop(pc.red('Installation failed.'));
    console.error(pc.red(String(err)));
    process.exit(1);
  }

  // Next steps
  const steps: string[] = [];
  if (editor === 'claude-code' || editor === 'both') {
    steps.push('Run /rex in Claude Code to start Rex');
  }
  if (editor === 'cursor' || editor === 'both') {
    steps.push('Use @rex in Cursor to start Rex');
  }
  if (editor === 'none') {
    steps.push('Open agents/orchestrator-agent.md and load it as your agent');
  }
  steps.push('Drop any reference files in intake/ before your first session');
  steps.push('See WORKFLOW.md for the full guide');

  note(steps.map((step, i) => `${i + 1}. ${step}`).join('\n'), 'Next steps');

  outro(pc.bold('BurnProof-AgentFlow is ready. Go build something. ⚡'));
}

main().catch((err) => {
  console.error(pc.red('Unexpected error:'), err);
  process.exit(1);
});
