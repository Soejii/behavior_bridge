// BehaviorBridge — Design tokens, icons, sample data, analysis engine
// Clinical + trustworthy aesthetic: indigo-blue accent, calm greens, warm amber.
// All tokens consumed via `const t = getTokens(accent)`.

// ─────────────────────────────────────────────────────────────
// Tokens
// ─────────────────────────────────────────────────────────────
const ACCENT_PRESETS = {
  indigo:  { name: 'Indigo',  h: 245, stroke: '#3A5FCD', tint: '#EEF1FB', tintDeep: '#DDE3F5', pillFg: '#2B47A0' },
  teal:    { name: 'Teal',    h: 195, stroke: '#1E7F8F', tint: '#E7F4F6', tintDeep: '#CEE6EA', pillFg: '#145C69' },
  forest:  { name: 'Forest',  h: 155, stroke: '#2F6F5B', tint: '#E7F2ED', tintDeep: '#CDE3D9', pillFg: '#1F4F3F' },
  slate:   { name: 'Slate',   h: 220, stroke: '#3B4A63', tint: '#ECEEF2', tintDeep: '#D6DAE2', pillFg: '#273448' },
};

function getTokens(accentKey = 'indigo', density = 'comfortable') {
  const a = ACCENT_PRESETS[accentKey] || ACCENT_PRESETS.indigo;
  const d = density === 'compact' ? 0.85 : 1;
  return {
    accent: a,
    // neutrals — warm-cool neutrals per clinical feel
    ink:        '#0E1420',
    ink2:       '#32405A',
    ink3:       '#5F6B82',
    ink4:       '#8A94A8',
    line:       '#E5E9F0',
    line2:      '#EEF1F6',
    bg:         '#F6F7FB',
    bgDeep:     '#EDEFF5',
    card:       '#FFFFFF',
    // semantic
    ok:         '#2F9E6E',
    okTint:     '#E3F4EB',
    okDark:     '#1E6A49',
    warn:       '#C98A1E',
    warnTint:   '#FBF1DC',
    warnDark:   '#7A5210',
    risk:       '#C0432E',
    riskTint:   '#F8E2DC',
    // font
    font: '"Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", system-ui, sans-serif',
    mono: '"IBM Plex Mono", ui-monospace, "SF Mono", Menlo, Consolas, monospace',
    // density scale (multiplier on paddings)
    d,
    r:    { sm: 6, md: 10, lg: 14, xl: 20, pill: 999 },
    // shadow
    sh1:  '0 1px 2px rgba(14,20,32,0.04), 0 1px 1px rgba(14,20,32,0.03)',
    sh2:  '0 1px 3px rgba(14,20,32,0.06), 0 8px 24px rgba(14,20,32,0.05)',
  };
}

// ─────────────────────────────────────────────────────────────
// Minimal icons (stroke, 20px viewBox)
// ─────────────────────────────────────────────────────────────
function Icon({ name, size = 20, color = 'currentColor', strokeWidth = 1.6 }) {
  const p = { width: size, height: size, viewBox: '0 0 20 20', fill: 'none', stroke: color, strokeWidth, strokeLinecap: 'round', strokeLinejoin: 'round' };
  switch (name) {
    case 'plus':      return <svg {...p}><path d="M10 4v12M4 10h12"/></svg>;
    case 'check':     return <svg {...p}><path d="M4 10.5l4 4 8-9"/></svg>;
    case 'x':         return <svg {...p}><path d="M5 5l10 10M15 5L5 15"/></svg>;
    case 'chev-r':    return <svg {...p}><path d="M7.5 4.5l5 5.5-5 5.5"/></svg>;
    case 'chev-l':    return <svg {...p}><path d="M12.5 4.5l-5 5.5 5 5.5"/></svg>;
    case 'chev-d':    return <svg {...p}><path d="M4.5 7.5l5.5 5 5.5-5"/></svg>;
    case 'spark':     return <svg {...p}><path d="M10 3v3M10 14v3M3 10h3M14 10h3M5 5l2 2M13 13l2 2M15 5l-2 2M5 15l2-2"/></svg>;
    case 'target':    return <svg {...p}><circle cx="10" cy="10" r="6"/><circle cx="10" cy="10" r="2.5"/><path d="M10 2v2M10 16v2M2 10h2M16 10h2"/></svg>;
    case 'trend':     return <svg {...p}><path d="M3 14l4-4 3 3 7-7"/><path d="M12 6h5v5"/></svg>;
    case 'sched':     return <svg {...p}><rect x="3" y="4" width="14" height="13" rx="2"/><path d="M7 2v4M13 2v4M3 8.5h14"/></svg>;
    case 'book':      return <svg {...p}><path d="M4 4h6a3 3 0 013 3v10a2 2 0 00-2-2H4V4z"/><path d="M16 4h-6a3 3 0 00-3 3v10a2 2 0 012-2h7V4z"/></svg>;
    case 'bell':      return <svg {...p}><path d="M6 7a4 4 0 118 0c0 4 2 5 2 6H4c0-1 2-2 2-6zM8.5 16a1.5 1.5 0 003 0"/></svg>;
    case 'warn':      return <svg {...p}><path d="M10 3l8 14H2L10 3z"/><path d="M10 8v4M10 14.5v.5"/></svg>;
    case 'cel':       return <svg {...p}><path d="M3 17l5-13 2 5 7-3-5 13z"/><path d="M8 4l2 5"/></svg>;
    case 'user':      return <svg {...p}><circle cx="10" cy="7" r="3"/><path d="M4 17c1.2-3 3.5-4 6-4s4.8 1 6 4"/></svg>;
    case 'grid':      return <svg {...p}><rect x="3" y="3" width="6" height="6" rx="1"/><rect x="11" y="3" width="6" height="6" rx="1"/><rect x="3" y="11" width="6" height="6" rx="1"/><rect x="11" y="11" width="6" height="6" rx="1"/></svg>;
    case 'list':      return <svg {...p}><path d="M6 5h11M6 10h11M6 15h11"/><circle cx="3.5" cy="5" r=".8" fill={color}/><circle cx="3.5" cy="10" r=".8" fill={color}/><circle cx="3.5" cy="15" r=".8" fill={color}/></svg>;
    case 'info':      return <svg {...p}><circle cx="10" cy="10" r="7"/><path d="M10 9v5M10 6v.5"/></svg>;
    case 'more':      return <svg {...p}><circle cx="4.5" cy="10" r="1.2" fill={color}/><circle cx="10" cy="10" r="1.2" fill={color}/><circle cx="15.5" cy="10" r="1.2" fill={color}/></svg>;
    case 'star':      return <svg {...p}><path d="M10 3l2.2 4.6 5 .6-3.7 3.5.9 4.9L10 14.3l-4.4 2.3.9-4.9-3.7-3.5 5-.6z"/></svg>;
    case 'pencil':    return <svg {...p}><path d="M4 16l1-4 8-8 3 3-8 8-4 1z"/></svg>;
    case 'dots':      return <svg {...p}><circle cx="10" cy="4.5" r="1.2" fill={color}/><circle cx="10" cy="10" r="1.2" fill={color}/><circle cx="10" cy="15.5" r="1.2" fill={color}/></svg>;
    case 'arrow-r':   return <svg {...p}><path d="M4 10h12M12 5l4 5-4 5"/></svg>;
    case 'calendar':  return <svg {...p}><rect x="3" y="5" width="14" height="12" rx="2"/><path d="M3 9h14M8 3v4M12 3v4"/></svg>;
    case 'home':      return <svg {...p}><path d="M3 10l7-6 7 6v7a1 1 0 01-1 1h-3v-5H7v5H4a1 1 0 01-1-1v-7z"/></svg>;
    case 'flag':      return <svg {...p}><path d="M5 3v14M5 4h9l-2 3 2 3H5"/></svg>;
    default: return null;
  }
}

// ─────────────────────────────────────────────────────────────
// Sample subjects + targets + logs
// Centered around "Maya · Tidying up toys after play" — all states
// switch off this one target, with different synthetic log histories.
// ─────────────────────────────────────────────────────────────
const SUBJECTS = [
  { id: 's1', name: 'Maya', ageYears: 6, relationship: 'parent',  emoji: 'M', createdAt: '2026-03-08', targetCount: 2 },
  { id: 's2', name: 'Owen', ageYears: 8, relationship: 'parent',  emoji: 'O', createdAt: '2026-03-14', targetCount: 1 },
  { id: 's3', name: 'Grade 2 · Desk B', ageYears: 7, relationship: 'teacher', emoji: '2B', createdAt: '2026-02-28', targetCount: 3 },
];

const TARGET = {
  id: 't1',
  subjectId: 's1',
  label: 'Tidying up toys after play',
  description: 'Puts all toys into the toy bin within 5 minutes of being asked.',
  baselineFrequency: 1,
  goalFrequency: 4,
  isIncreasing: true,
  startDate: '2026-04-01',
  isActive: true,
};

const SCHEDULE = {
  id: 'sch1',
  targetId: 't1',
  type: 'continuousReinforcement',
  ratio: 1,
  intervalMinutes: 0,
  reinforcerDescription: 'Sticker on the chart · 5 min screen time at 4 stickers',
  appliedAt: '2026-04-01',
};

// 21-day synthetic series per state. index 0 = oldest. goal = 4.
const LOG_SERIES = {
  baseline:      [1, 2, 1],
  onTrack:       [1, 2, 1, 2, 3, 3, 4, 3, 4, 3, 4, 4, 3, 4],
  scheduleUpgrade: [1, 2, 1, 2, 3, 3, 4, 3, 4, 4, 4, 4, 4, 5, 4, 4],
  plateau:       [1, 2, 1, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3],
  extinctionRisk:[1, 2, 1, 2, 3, 3, 4, 4, 4, 4, 3, 2, 2, 1, 1],
  goalReached:   [1, 2, 1, 2, 3, 3, 4, 3, 4, 4, 4, 5, 4, 4, 5, 5, 4, 5, 4, 4, 5],
};

// Per-day reinforcement given? (arrays line up with LOG_SERIES above)
const REINF_SERIES = {
  baseline:       [false, false, false],
  onTrack:        Array(14).fill(true),
  scheduleUpgrade:Array(16).fill(true),
  plateau:        Array(16).fill(true),
  extinctionRisk: [...Array(10).fill(true), false, false, false, false, false],
  goalReached:    Array(21).fill(true),
};

// ─────────────────────────────────────────────────────────────
// Analysis results (§6 of spec) — precomputed per state
// ─────────────────────────────────────────────────────────────
const ANALYSIS = {
  baseline: {
    status: 'baseline',
    headline: 'Keep observing — 3 of 3 days logged',
    explanation: 'Great start! A few baseline days help us understand where Maya is now, before we suggest a plan. Log tomorrow to unlock your first recommendation.',
    suggestedSchedule: null,
    actionableAdvice: null,
    pillLabel: 'Baseline',
    pillTone: 'neutral',
  },
  onTrack: {
    status: 'onTrack',
    headline: 'Nice progress — on track toward goal',
    explanation: 'Maya is reaching 3–4 tidy-ups per day, right up near the goal of 4. Keep giving a sticker every single time — consistency is what makes a new habit stick.',
    suggestedSchedule: null,
    actionableAdvice: 'Stay on "Every time" for a few more days.',
    pillLabel: 'On track',
    pillTone: 'ok',
  },
  scheduleUpgrade: {
    status: 'scheduleUpgrade',
    headline: 'Great streak! Time to mix up the rewards',
    explanation: 'Maya has hit the goal 7 days in a row — the behavior is now well-practiced. Research shows that rewarding every 2 times (instead of every time) actually makes the habit stronger and more lasting.',
    suggestedSchedule: 'fixedRatio',
    actionableAdvice: 'Switch to rewarding every 2nd tidy-up.',
    pillLabel: 'Ready to upgrade',
    pillTone: 'ok',
  },
  plateau: {
    status: 'plateauDetected',
    headline: 'Progress has flattened — let\'s adjust',
    explanation: 'For the past 5 days, Maya has been steady at 3 tidy-ups per day but hasn\'t reached 4. This is a common plateau. A fresh reward or a slightly easier goal can spark new motivation.',
    suggestedSchedule: null,
    actionableAdvice: 'Try a more motivating reward, or reward every time again for a few days.',
    pillLabel: 'Plateau detected',
    pillTone: 'warn',
  },
  extinctionRisk: {
    status: 'extinctionRisk',
    headline: 'Rewards have slipped — let\'s get back on track',
    explanation: 'Reinforcement was skipped for the last 4 days, and Maya\'s tidy-ups are dropping. Behaviors weaken quickly when rewards stop. Hand out a sticker today for the next tidy-up you see.',
    suggestedSchedule: null,
    actionableAdvice: 'Resume giving rewards consistently, starting today.',
    pillLabel: 'Reward lapse',
    pillTone: 'risk',
  },
  goalReached: {
    status: 'goalReached',
    headline: 'Goal reached — 21 days of steady tidy-ups 🎉',
    explanation: 'Maya has met or exceeded 4 tidy-ups per day for the last 7 days straight, and stayed strong for 3 full weeks. The habit is established.',
    suggestedSchedule: 'variableRatio',
    actionableAdvice: 'Move to surprise rewards to keep it going long-term.',
    pillLabel: 'Goal reached',
    pillTone: 'ok',
  },
};

const STATE_OPTIONS = [
  { key: 'baseline',         name: 'Baseline (day 3)' },
  { key: 'onTrack',          name: 'On track' },
  { key: 'scheduleUpgrade',  name: 'Ready to upgrade' },
  { key: 'plateau',          name: 'Plateau detected' },
  { key: 'extinctionRisk',   name: 'Extinction risk' },
  { key: 'goalReached',      name: 'Goal reached' },
];

// Dates go backward from "today" (Apr 21, 2026). Returns ISO date strings.
function datesFor(n, end = new Date('2026-04-21T12:00:00Z')) {
  const out = [];
  for (let i = n - 1; i >= 0; i--) {
    const d = new Date(end);
    d.setUTCDate(d.getUTCDate() - i);
    out.push(d.toISOString().slice(0, 10));
  }
  return out;
}

// ─────────────────────────────────────────────────────────────
// Pill / badge
// ─────────────────────────────────────────────────────────────
function Pill({ tone = 'neutral', children, t, size = 'md' }) {
  const fs = size === 'sm' ? 11 : 12;
  const pd = size === 'sm' ? '3px 8px' : '5px 10px';
  const palette = {
    neutral: { bg: t.line2, fg: t.ink2, dot: t.ink3 },
    ok:      { bg: t.okTint, fg: t.okDark, dot: t.ok },
    warn:    { bg: t.warnTint, fg: t.warnDark, dot: t.warn },
    risk:    { bg: t.riskTint, fg: t.risk, dot: t.risk },
    accent:  { bg: t.accent.tint, fg: t.accent.pillFg, dot: t.accent.stroke },
  }[tone];
  return (
    <span style={{
      display: 'inline-flex', alignItems: 'center', gap: 6,
      padding: pd, borderRadius: 999, background: palette.bg, color: palette.fg,
      fontSize: fs, fontWeight: 600, letterSpacing: 0.1, whiteSpace: 'nowrap',
    }}>
      <span style={{ width: 6, height: 6, borderRadius: 999, background: palette.dot }} />
      {children}
    </span>
  );
}

Object.assign(window, {
  getTokens, ACCENT_PRESETS, Icon, SUBJECTS, TARGET, SCHEDULE,
  LOG_SERIES, REINF_SERIES, ANALYSIS, STATE_OPTIONS, datesFor, Pill,
});
