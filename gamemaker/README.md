# Disciples — The Way (GameMaker Studio 2)

Beat-em-up in the spirit of *TMNT: Turtles in Time* (SNES, 1992), themed around
Jesus and the Twelve as portrayed in *The Chosen*. Jesus plays the
Splinter / mentor role; the four playable heroes are Peter, John, James, and
Matthew.

This folder is the **GameMaker Studio 2 source skeleton** for the project. It
sits next to the existing web prototype (`../index.html`) at the repo root —
both projects share the repo, neither touches the other.

---

## What's in this drop (MVP)

The smallest end-to-end runnable slice:

* Title screen → character select (Peter live; J / J / M stubbed) → Galilee
  wave 1 (3 bandits) → win screen.
* Working systems: 8-way movement, jump, data-driven combo state machine,
  grab + throw, special-move meter, Summon Jesus charge, sanctification halo
  HUD, hidden enemy HP with animation cues, prayer / mercy / conversion,
  walkover-converts-praying-enemy, side-scroll camera with no-backtrack and
  wave lock, hit-stop and screen shake.
* All sprites are placeholder colored rectangles with name tags. Replace in
  Aseprite later.
* No sounds yet — three named folders only (`snd_punch`, `snd_pray`,
  `snd_summon`) so the resource layout is stable when audio drops in.

What's intentionally **deferred** to follow-ups:

* Full movesets for John, James, Matthew (their stubs use a single basic jab).
* AI behaviour for Roman / Barabbas / Pharisee / False Prophet / Money Changer
  (their Create files only set stats — they inherit the bandit-style AI).
* Levels 2 (Wilderness Road) and 3 (Temple Courts).
* Story-beat dialogue boxes.
* Real sprites and audio.
* Pause menu, save system, multi-player input.

---

## Source layout

```
gamemaker/
├── README.md                ← you are here
├── .gitignore
└── src/
    ├── objects/             ← one folder per object, one .gml per event
    │   ├── obj_player_base/      Create_0, Step_0, Draw_0
    │   ├── obj_player_peter/     Create_0
    │   ├── obj_player_john/      Create_0   (stub moveset)
    │   ├── obj_player_james/     Create_0   (stub moveset)
    │   ├── obj_player_matthew/   Create_0   (stub moveset)
    │   ├── obj_enemy_parent/     Create_0, Step_0, Draw_0
    │   ├── obj_enemy_bandit/     Create_0
    │   ├── obj_enemy_roman/      Create_0   (stat stub)
    │   ├── obj_enemy_barabbas/   Create_0   (stat stub)
    │   ├── obj_enemy_pharisee/   Create_0   (stat stub)
    │   ├── obj_enemy_false_prophet/  Create_0   (stat stub)
    │   ├── obj_enemy_money_changer/  Create_0   (stat stub)
    │   ├── obj_hitbox/           Create_0, Step_0
    │   ├── obj_camera/           Create_0, Step_0
    │   ├── obj_controller/       Create_0, Step_0, Draw_GUI_0
    │   ├── obj_jesus_mentor/     Create_0, Step_0, Draw_0
    │   ├── obj_title/            Create_0, Step_0, Draw_GUI_0
    │   ├── obj_character_select/ Create_0, Step_0, Draw_GUI_0
    │   └── obj_win_screen/       Create_0, Step_0, Draw_GUI_0
    ├── scripts/
    │   ├── scr_constants.gml     enums + tunables
    │   ├── scr_helpers.gml       sanctification, halo, hitbox spawn
    │   ├── scr_movesets.gml      Peter filled, J/J/M stubs
    │   └── scr_level_system.gml  wave structs (Galilee wave 1 only)
    ├── rooms/
    │   ├── rm_title/             empty — created in IDE
    │   ├── rm_select/
    │   ├── rm_galilee/
    │   ├── rm_wilderness/        stub (no waves yet)
    │   ├── rm_temple/            stub
    │   └── rm_win/
    ├── sprites/                  empty named folders, fill in IDE
    └── sounds/                   empty named folders, fill later
```

---

## Setup checklist (one-time, ~30–60 minutes)

GameMaker Studio 2 owns project files (`.yyp` / `.yy`) with auto-generated
GUIDs. We deliberately don't ship them — hand-written GUIDs are fragile and
one wrong reference breaks the project. Instead you create the resources in
the IDE and point each event at the `.gml` files in this repo.

### 1. Create the project

1. Open GameMaker Studio 2.
2. File → New → **GameMaker Language** project.
3. Name it `DisciplesTheWay`. Save it directly into this `gamemaker/` folder
   (so the resulting `DisciplesTheWay.yyp` lives next to this README).

### 2. Add the scripts

For each file in `src/scripts/`:

1. In GM, Resources → Create → Script.
2. Name it the same as the file (e.g. `scr_constants`).
3. Open the script and **replace its contents** by pasting the matching
   `src/scripts/<name>.gml`.

Order matters for the `#macro` definitions — create `scr_constants` first.

### 3. Add the parent objects (player + enemy bases)

For each parent object, create the resource in GM, then for each event that
exists in `src/objects/<obj>/`, add that event in the IDE and paste the
matching `.gml` file in.

* **`obj_player_base`** — Create, Step, Draw. No sprite needed (draws
  rectangles via code).
* **`obj_enemy_parent`** — Create, Step, Draw. No sprite needed.

### 4. Add the four disciples (children of `obj_player_base`)

For each: create the object, set its **Parent Object** to `obj_player_base`,
add a Create event, and paste:

* `obj_player_peter`   — Create only
* `obj_player_john`    — Create only
* `obj_player_james`   — Create only
* `obj_player_matthew` — Create only

### 5. Add the six enemies (children of `obj_enemy_parent`)

For each: create the object, set its **Parent Object** to `obj_enemy_parent`,
add a Create event, and paste:

* `obj_enemy_bandit`
* `obj_enemy_roman`
* `obj_enemy_barabbas`
* `obj_enemy_pharisee`
* `obj_enemy_false_prophet`
* `obj_enemy_money_changer`

### 6. Add the engine objects

* **`obj_hitbox`** — Create, Step.
* **`obj_camera`** — Create, Step.
* **`obj_controller`** — Create, Step, Draw GUI.
* **`obj_jesus_mentor`** — Create, Step, Draw.

### 7. Add the screen objects

* **`obj_title`** — Create, Step, Draw GUI.
* **`obj_character_select`** — Create, Step, Draw GUI.
* **`obj_win_screen`** — Create, Step, Draw GUI.

### 8. Add the rooms

Resources → Create → Room. Create:

* `rm_title`
* `rm_select`
* `rm_galilee`         (the playable MVP room)
* `rm_wilderness`      (stub — empty for now)
* `rm_temple`          (stub — empty)
* `rm_win`

For each room, set:

* **Width:** 1280 (gameplay rooms can be wider; `rm_galilee` should be ~2400
  so the camera has somewhere to scroll)
* **Height:** 360
* **Viewport 0:** Visible, Camera 640 × 360, Viewport 640 × 360, Object
  following = leave blank (the camera object handles it)

Then drop instances:

* `rm_title`         → one `obj_title`
* `rm_select`        → one `obj_character_select`
* `rm_galilee`       → one `obj_camera`, one `obj_controller`. Do NOT place
  the player or any enemies — `obj_controller` spawns the player on Create
  and the wave system spawns enemies.
* `rm_win`           → one `obj_win_screen`

In **Game Options → General → Set first room to:** `rm_title`. To skip
straight into combat while iterating, edit `scr_constants.gml` and set
`#macro DEBUG_FAST_BOOT true`.

### 9. (Optional) Placeholder sprites

The Draw events render colored rectangles, so sprites aren't strictly
required. If GM complains, create empty sprites named:

* `spr_peter_idle`, `spr_bandit_idle`, `spr_halo`, `spr_hitbox_debug`

…and assign them to the matching objects' Sprite slots. Any 1×1 placeholder
image works.

### 10. (Optional) Sound stubs

Create empty Sound resources named `snd_punch`, `snd_pray`, `snd_summon` if
you want to wire audio later. The MVP code makes no `audio_play_sound` calls
(audio is deferred).

---

## Smoke test

Once everything is wired, press **F5**. Expected first run:

| # | Action | Expected |
|---|--------|----------|
| 1 | Compile | No missing-asset / undefined-name errors. |
| 2 | Boot | `rm_title` shows "DISCIPLES — THE WAY" with a pulsing prompt. |
| 3 | Press Enter | Reaches `rm_select`. Peter is highlighted; J/J/M are greyed and tagged "STUB". |
| 4 | Confirm Peter | Spawns in `rm_galilee` at left edge. Three bandits visible to the right. |
| 5 | Move (arrows) | Peter walks; camera follows but cannot scroll backward. |
| 6 | Attack (X) | Peter swings combo. Bandits flash and stagger. |
| 7 | Damage a bandit below 33% HP | Bandit shows sweat drops above its head (the "hidden HP" cue). |
| 8 | Defeat a bandit | ~40% kneel and pray (blue halo); ~60% flee off-screen. |
| 9 | Walk over a praying bandit | CONVERT — bandit poofs, your halo brightens, +15 sanct. |
| 10 | Attack a praying bandit | KILL — bandit flees, your halo darkens, −25 sanct. |
| 11 | Press C | Summon Jesus — all praying enemies converted at once. |
| 12 | Clear the wave | After a 1-second pause, transitions to `rm_win`. |
| 13 | Press Enter on win screen | Returns to `rm_title`. |

If steps 1–4 work, the wiring is correct. If 5–10 work, combat + sanctification
are correct. Report which step fails and we iterate.

---

## Linux note

GameMaker Studio 2's stable IDE runs on Windows and macOS. The Linux IDE is
beta-only as of 2026 and may be flaky. If you can't get the IDE running on
Linux, the cleanest options are:

1. Use the IDE on a Windows or Mac box — the project files in this folder are
   plain text and sync fine over git.
2. Run the IDE under Wine / Proton.
3. Ask before we go further if you want to switch to Godot 4 or LOVE2D, both
   of which have first-class Linux support and similar scope for this game.

---

## Next steps after MVP boots

Roughly in priority order:

1. Real movesets for John (Light of the World), James (Thunder Roll),
   Matthew (Render Unto Caesar).
2. Per-archetype enemy AI: Roman blocks, Pharisee buffs allies, Money
   Changer drops blessing-coin pickup on conversion.
3. Galilee waves 2–4 plus the Barabbas mini-boss fight.
4. Wilderness Road (False Prophet two-phase) and Temple Courts (Caiaphas's
   lieutenants).
5. Story-beat dialogue boxes and the *Chosen*-style hideout hub between
   levels.
6. Aseprite sprite pass.
7. Audio pass (Itch.io placeholders).
8. Pause / save / co-op input wiring.
