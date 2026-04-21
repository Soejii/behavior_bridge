// BehaviorBridge — Web dashboard screen (1440×900)
// Sidebar (subjects) · Main (target + chart + logs) · Right rail (suggestion + schedule)

const WEB_W = 1440;
const WEB_H = 900;

function WButton({ t, children, variant = 'primary', icon, size = 'md' }) {
  const st = {
    primary:   { bg: t.accent.stroke, fg: '#fff', border: t.accent.stroke },
    secondary: { bg: t.card, fg: t.ink, border: t.line },
    ghost:     { bg: 'transparent', fg: t.ink2, border: 'transparent' },
    dark:      { bg: t.ink, fg: '#fff', border: t.ink },
  }[variant];
  const pd = size === 'sm' ? '6px 12px' : '9px 16px';
  const fs = size === 'sm' ? 12 : 13.5;
  return (
    <button style={{
      background: st.bg, color: st.fg, border: `1px solid ${st.border}`,
      padding: pd, borderRadius: 8, fontSize: fs, fontWeight: 600,
      fontFamily: t.font, cursor: 'pointer', display: 'inline-flex',
      alignItems: 'center', gap: 6, letterSpacing: -0.1,
    }}>{icon}{children}</button>
  );
}

function SidebarRow({ t, active, children, badge, icon }) {
  return (
    <div style={{
      display: 'flex', alignItems: 'center', gap: 10,
      padding: '8px 10px', borderRadius: 8, cursor: 'pointer',
      background: active ? t.accent.tint : 'transparent',
      color: active ? t.accent.pillFg : t.ink2,
      fontSize: 13, fontWeight: active ? 600 : 500,
    }}>
      {icon}
      <span style={{ flex: 1 }}>{children}</span>
      {badge}
    </div>
  );
}

function WebScreen({ t, stateKey }) {
  const values = LOG_SERIES[stateKey];
  const reinf  = REINF_SERIES[stateKey];
  const a = ANALYSIS[stateKey];
  const dates = datesFor(values.length);
  const goal = TARGET.goalFrequency;
  const avg = (values.reduce((x, y) => x + y, 0) / values.length).toFixed(1);
  const daysAtGoal = values.filter((v) => v >= goal).length;

  const heroTint = a.pillTone === 'ok' ? t.okTint : a.pillTone === 'warn' ? t.warnTint : a.pillTone === 'risk' ? t.riskTint : t.accent.tint;
  const heroLine = a.pillTone === 'ok' ? t.ok : a.pillTone === 'warn' ? t.warn : a.pillTone === 'risk' ? t.risk : t.accent.stroke;
  const heroFg   = a.pillTone === 'ok' ? t.okDark : a.pillTone === 'warn' ? t.warnDark : a.pillTone === 'risk' ? t.risk : t.accent.pillFg;

  // latest 5 logs table
  const latest = values.slice(-7).map((v, i) => {
    const absIdx = values.length - (7 - i) < 0 ? i : values.length - 7 + i;
    return {
      date: dates[absIdx],
      count: v,
      reinf: reinf[absIdx],
      atGoal: v >= goal,
    };
  });

  return (
    <div style={{
      width: WEB_W, height: WEB_H, background: t.bg, fontFamily: t.font,
      color: t.ink, display: 'flex', overflow: 'hidden', WebkitFontSmoothing: 'antialiased',
    }}>
      {/* Sidebar */}
      <div style={{ width: 248, background: t.card, borderRight: `1px solid ${t.line}`, display: 'flex', flexDirection: 'column', flexShrink: 0 }}>
        <div style={{ padding: '20px 20px 16px', display: 'flex', alignItems: 'center', gap: 10 }}>
          <div style={{ width: 28, height: 28, borderRadius: 8, background: t.accent.stroke, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#fff' }}>
            <Icon name="spark" size={16}/>
          </div>
          <div style={{ fontSize: 15, fontWeight: 700, letterSpacing: -0.2 }}>BehaviorBridge</div>
        </div>

        <div style={{ padding: '4px 12px' }}>
          <div style={{ padding: '0 10px', fontSize: 10, fontWeight: 700, color: t.ink4, textTransform: 'uppercase', letterSpacing: 0.6, margin: '10px 0 6px' }}>Today</div>
          <SidebarRow t={t} icon={<Icon name="home" size={16} color={t.ink3}/>}>Overview</SidebarRow>
          <SidebarRow t={t} icon={<Icon name="bell" size={16} color={t.ink3}/>} badge={<span style={{ fontSize: 10, fontWeight: 700, color: t.warn, background: t.warnTint, padding: '2px 6px', borderRadius: 99 }}>1</span>}>Suggestions</SidebarRow>

          <div style={{ padding: '0 10px', fontSize: 10, fontWeight: 700, color: t.ink4, textTransform: 'uppercase', letterSpacing: 0.6, margin: '16px 0 6px' }}>Children</div>
          <SidebarRow t={t} active icon={
            <div style={{ width: 20, height: 20, borderRadius: 5, background: t.accent.tint, color: t.accent.pillFg, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 10, fontWeight: 700 }}>M</div>
          } badge={<span style={{ fontSize: 10, color: t.ink3 }}>2</span>}>Maya</SidebarRow>
          <SidebarRow t={t} icon={
            <div style={{ width: 20, height: 20, borderRadius: 5, background: t.okTint, color: t.okDark, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 10, fontWeight: 700 }}>O</div>
          } badge={<span style={{ fontSize: 10, color: t.ink3 }}>1</span>}>Owen</SidebarRow>
          <SidebarRow t={t} icon={
            <div style={{ width: 20, height: 20, borderRadius: 5, background: t.warnTint, color: t.warnDark, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 9, fontWeight: 700 }}>2B</div>
          } badge={<span style={{ fontSize: 10, color: t.ink3 }}>3</span>}>Grade 2 · Desk B</SidebarRow>
          <div style={{ padding: '6px 10px', color: t.ink3, fontSize: 12, display: 'flex', alignItems: 'center', gap: 6, cursor: 'pointer' }}>
            <Icon name="plus" size={13}/> Add child
          </div>

          <div style={{ padding: '0 10px', fontSize: 10, fontWeight: 700, color: t.ink4, textTransform: 'uppercase', letterSpacing: 0.6, margin: '16px 0 6px' }}>Library</div>
          <SidebarRow t={t} icon={<Icon name="book" size={16} color={t.ink3}/>}>About reinforcement</SidebarRow>
          <SidebarRow t={t} icon={<Icon name="info" size={16} color={t.ink3}/>}>How to spot plateaus</SidebarRow>
        </div>

        <div style={{ flex: 1 }}/>

        <div style={{ padding: 14, borderTop: `1px solid ${t.line}`, display: 'flex', alignItems: 'center', gap: 10 }}>
          <div style={{ width: 30, height: 30, borderRadius: 99, background: t.line2, color: t.ink2, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <Icon name="user" size={17}/>
          </div>
          <div style={{ flex: 1, minWidth: 0 }}>
            <div style={{ fontSize: 12, fontWeight: 600 }}>Parent · Device only</div>
            <div style={{ fontSize: 10, color: t.ink3 }}>No account needed</div>
          </div>
        </div>
      </div>

      {/* Main column */}
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', minWidth: 0 }}>
        {/* Top bar */}
        <div style={{ padding: '18px 28px 14px', borderBottom: `1px solid ${t.line}`, background: t.card, display: 'flex', alignItems: 'center', gap: 16 }}>
          <div>
            <div style={{ fontSize: 11, color: t.ink3, display: 'flex', alignItems: 'center', gap: 5 }}>
              Maya <Icon name="chev-r" size={11} color={t.ink4}/> Behavior target
            </div>
            <div style={{ fontSize: 20, fontWeight: 700, letterSpacing: -0.3, marginTop: 2 }}>{TARGET.label}</div>
          </div>
          <div style={{ flex: 1 }}/>
          <Pill t={t} tone={a.pillTone}>{a.pillLabel}</Pill>
          <WButton t={t} variant="secondary" icon={<Icon name="pencil" size={14}/>}>Edit</WButton>
          <WButton t={t} icon={<Icon name="check" size={14} color="#fff"/>}>Log today</WButton>
        </div>

        {/* Stats strip */}
        <div style={{ padding: '18px 28px 0', display: 'grid', gridTemplateColumns: 'repeat(5,1fr)', gap: 12 }}>
          {[
            { label: 'Goal',     val: `${goal}×/day`, sub: 'Increase' },
            { label: 'Baseline', val: `${TARGET.baselineFrequency}×/day`, sub: 'Apr 1' },
            { label: 'Avg/day',  val: avg,             sub: `Last ${values.length}d` },
            { label: 'At goal',  val: `${daysAtGoal}d`, sub: `of ${values.length}d logged` },
            { label: 'Schedule', val: stateKey === 'scheduleUpgrade' || stateKey === 'goalReached' ? 'Every 2nd' : 'Every time', sub: stateKey === 'scheduleUpgrade' || stateKey === 'goalReached' ? 'FR-2' : 'CRF' },
          ].map((s) => (
            <div key={s.label} style={{ background: t.card, border: `1px solid ${t.line}`, borderRadius: t.r.lg, padding: '12px 14px' }}>
              <div style={{ fontSize: 10, fontWeight: 700, color: t.ink3, textTransform: 'uppercase', letterSpacing: 0.5 }}>{s.label}</div>
              <div style={{ fontSize: 22, fontWeight: 700, fontFamily: t.mono, marginTop: 4, letterSpacing: -0.5 }}>{s.val}</div>
              <div style={{ fontSize: 11, color: t.ink3, marginTop: 2 }}>{s.sub}</div>
            </div>
          ))}
        </div>

        {/* Chart card */}
        <div style={{ padding: '18px 28px' }}>
          <div style={{ background: t.card, border: `1px solid ${t.line}`, borderRadius: t.r.xl, padding: 20, boxShadow: t.sh1 }}>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 10 }}>
              <div>
                <div style={{ fontSize: 13, fontWeight: 700 }}>Daily occurrences</div>
                <div style={{ fontSize: 12, color: t.ink3, marginTop: 2 }}>Times per day · goal line shown · schedule changes marked</div>
              </div>
              <div style={{ display: 'flex', gap: 6 }}>
                {['7d','14d','30d','All'].map((r, i) => (
                  <div key={r} style={{
                    padding: '5px 10px', borderRadius: 7, fontSize: 11, fontWeight: 600,
                    background: i === 1 ? t.ink : 'transparent', color: i === 1 ? '#fff' : t.ink3,
                    cursor: 'pointer',
                  }}>{r}</div>
                ))}
              </div>
            </div>
            <ProgressChart
              values={values}
              goal={goal}
              width={760}
              height={240}
              t={t}
              scheduleChanges={stateKey === 'scheduleUpgrade' || stateKey === 'goalReached' ? [6] : []}
            />
            <div style={{ display: 'flex', gap: 18, marginTop: 14, fontSize: 11, color: t.ink3 }}>
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6 }}><span style={{ width: 10, height: 2, background: t.accent.stroke, borderRadius: 1 }}/> Occurrences</span>
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6 }}><span style={{ width: 10, height: 2, background: t.ok, borderRadius: 1 }}/> Goal</span>
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6 }}><span style={{ width: 6, height: 6, background: t.ok, borderRadius: 99 }}/> Day at goal</span>
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6 }}><span style={{ width: 6, height: 6, background: t.warn, borderRadius: 99 }}/> Below goal</span>
              <span style={{ display: 'inline-flex', alignItems: 'center', gap: 6 }}><span style={{ width: 6, height: 6, border: `1.2px solid ${t.accent.stroke}`, borderRadius: 99 }}/> Schedule change</span>
            </div>
          </div>
        </div>

        {/* Recent logs table */}
        <div style={{ padding: '0 28px 24px', flex: 1, overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
          <div style={{ background: t.card, border: `1px solid ${t.line}`, borderRadius: t.r.xl, overflow: 'hidden' }}>
            <div style={{ padding: '14px 20px', display: 'flex', alignItems: 'center', justifyContent: 'space-between', borderBottom: `1px solid ${t.line}` }}>
              <div style={{ fontSize: 13, fontWeight: 700 }}>Recent logs</div>
              <div style={{ fontSize: 12, color: t.ink3, display: 'flex', alignItems: 'center', gap: 4, cursor: 'pointer' }}>
                View all <Icon name="chev-r" size={12} color={t.ink3}/>
              </div>
            </div>
            <div>
              {/* header row */}
              <div style={{ display: 'grid', gridTemplateColumns: '110px 90px 90px 100px 1fr', padding: '10px 20px', fontSize: 10, fontWeight: 700, color: t.ink3, textTransform: 'uppercase', letterSpacing: 0.5, borderBottom: `1px solid ${t.line2}` }}>
                <div>Date</div><div>Count</div><div>Goal</div><div>Reward</div><div>Notes</div>
              </div>
              {latest.slice(-5).reverse().map((r, i) => (
                <div key={r.date} style={{
                  display: 'grid', gridTemplateColumns: '110px 90px 90px 100px 1fr',
                  padding: '11px 20px', fontSize: 13, color: t.ink2, alignItems: 'center',
                  borderBottom: i === 4 ? 'none' : `1px solid ${t.line2}`,
                }}>
                  <div style={{ fontFamily: t.mono, fontSize: 12, color: t.ink }}>{r.date.slice(5)}{i === 0 ? ' · today' : ''}</div>
                  <div style={{ fontFamily: t.mono, fontWeight: 700, color: r.atGoal ? t.okDark : t.ink, fontSize: 14 }}>{r.count}×</div>
                  <div>
                    {r.atGoal
                      ? <Pill t={t} tone="ok" size="sm">At goal</Pill>
                      : <Pill t={t} tone="warn" size="sm">-{goal - r.count}</Pill>}
                  </div>
                  <div>
                    {r.reinf
                      ? <span style={{ display: 'inline-flex', alignItems: 'center', gap: 4, color: t.ok, fontSize: 12 }}><Icon name="check" size={14}/> Given</span>
                      : <span style={{ display: 'inline-flex', alignItems: 'center', gap: 4, color: t.risk, fontSize: 12 }}><Icon name="x" size={14}/> Skipped</span>}
                  </div>
                  <div style={{ fontSize: 12, color: t.ink3, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                    {i === 0 ? 'Had to ask twice, but did it the second time.' :
                     i === 1 ? 'Straight away, no reminder needed 🎉' :
                     i === 2 ? '—' :
                     i === 3 ? 'Tired — asked after dinner.' :
                     'Proud of herself for finishing.'}
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>

      {/* Right rail */}
      <div style={{ width: 340, background: t.card, borderLeft: `1px solid ${t.line}`, padding: '18px 18px', display: 'flex', flexDirection: 'column', gap: 14, flexShrink: 0, overflow: 'auto' }}>
        {/* Suggestion */}
        <div style={{ background: heroTint, borderRadius: t.r.lg, padding: 16, border: `1px solid ${heroLine}33` }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 8 }}>
            <div style={{ width: 28, height: 28, borderRadius: 8, background: heroLine, color: '#fff', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <Icon name={a.pillTone === 'risk' ? 'warn' : a.pillTone === 'warn' ? 'info' : 'spark'} size={15} color="#fff"/>
            </div>
            <div style={{ fontSize: 11, fontWeight: 700, color: heroFg, textTransform: 'uppercase', letterSpacing: 0.5 }}>Suggestion</div>
          </div>
          <div style={{ fontSize: 16, fontWeight: 700, color: t.ink, lineHeight: 1.3, letterSpacing: -0.2 }}>{a.headline}</div>
          <div style={{ fontSize: 12.5, color: t.ink2, marginTop: 8, lineHeight: 1.55 }}>{a.explanation}</div>
          {a.actionableAdvice && (
            <div style={{ marginTop: 12, padding: 10, background: t.card, borderRadius: 8, display: 'flex', gap: 8, alignItems: 'flex-start' }}>
              <Icon name="flag" size={14} color={heroLine}/>
              <div style={{ fontSize: 12.5, fontWeight: 600, color: t.ink }}>{a.actionableAdvice}</div>
            </div>
          )}
          <div style={{ display: 'flex', gap: 8, marginTop: 12 }}>
            <WButton t={t} variant="dark" size="sm">
              {stateKey === 'scheduleUpgrade' ? 'Apply change' :
               stateKey === 'goalReached' ? 'Mark complete' :
               stateKey === 'plateau' ? 'Adjust reward' :
               stateKey === 'extinctionRisk' ? 'Set reminder' :
               'Acknowledge'}
            </WButton>
            <WButton t={t} variant="ghost" size="sm">Why?</WButton>
          </div>
        </div>

        {/* Current schedule */}
        <div>
          <div style={{ fontSize: 10, fontWeight: 700, color: t.ink3, textTransform: 'uppercase', letterSpacing: 0.6, marginBottom: 6 }}>Current schedule</div>
          <div style={{ background: t.card, border: `1px solid ${t.line}`, borderRadius: t.r.lg, padding: 14 }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 8 }}>
              <div style={{ width: 30, height: 30, borderRadius: 8, background: t.accent.tint, color: t.accent.stroke, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <Icon name="sched" size={16}/>
              </div>
              <div>
                <div style={{ fontSize: 13, fontWeight: 700 }}>
                  {stateKey === 'scheduleUpgrade' || stateKey === 'goalReached' ? 'Every 2nd time' : 'Every time'}
                </div>
                <div style={{ fontSize: 11, color: t.ink3 }}>
                  {stateKey === 'scheduleUpgrade' || stateKey === 'goalReached' ? 'Fixed ratio · FR-2' : 'Continuous reinforcement · CRF'}
                </div>
              </div>
            </div>
            <div style={{ fontSize: 12, color: t.ink2, padding: '8px 10px', background: t.bg, borderRadius: 7 }}>
              <span style={{ fontSize: 10, fontWeight: 700, color: t.ink3, textTransform: 'uppercase', letterSpacing: 0.5, display: 'block', marginBottom: 2 }}>Reward</span>
              Sticker on chart · 5 min screen time at 4 stickers
            </div>
          </div>
        </div>

        {/* Timeline */}
        <div>
          <div style={{ fontSize: 10, fontWeight: 700, color: t.ink3, textTransform: 'uppercase', letterSpacing: 0.6, marginBottom: 6 }}>Timeline</div>
          <div style={{ background: t.card, border: `1px solid ${t.line}`, borderRadius: t.r.lg, padding: 14, display: 'flex', flexDirection: 'column', gap: 10, position: 'relative' }}>
            {[
              { d: 'Apr 1',  label: 'Target created', kind: 'accent' },
              { d: 'Apr 3',  label: 'Baseline complete · 3 days', kind: 'neutral' },
              { d: 'Apr 4',  label: 'Started "Every time" rewards', kind: 'accent' },
              (stateKey === 'scheduleUpgrade' || stateKey === 'goalReached') && { d: 'Apr 14', label: 'Upgraded to "Every 2nd"', kind: 'ok' },
              stateKey === 'plateau' && { d: 'Apr 18', label: 'Plateau detected', kind: 'warn' },
              stateKey === 'extinctionRisk' && { d: 'Apr 19', label: 'Rewards skipped 3 days', kind: 'risk' },
              stateKey === 'goalReached' && { d: 'Apr 21', label: 'Goal reached 🎉', kind: 'ok' },
            ].filter(Boolean).map((e, i) => {
              const color = e.kind === 'ok' ? t.ok : e.kind === 'warn' ? t.warn : e.kind === 'risk' ? t.risk : e.kind === 'accent' ? t.accent.stroke : t.ink4;
              return (
                <div key={i} style={{ display: 'flex', gap: 10, alignItems: 'flex-start' }}>
                  <div style={{ width: 10, height: 10, borderRadius: 99, background: color, marginTop: 4, flexShrink: 0 }}/>
                  <div style={{ flex: 1 }}>
                    <div style={{ fontSize: 11, fontFamily: t.mono, color: t.ink3 }}>{e.d}</div>
                    <div style={{ fontSize: 12.5, color: t.ink }}>{e.label}</div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </div>
  );
}

Object.assign(window, { WebScreen, WEB_W, WEB_H });
