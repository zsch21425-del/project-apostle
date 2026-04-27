# Disciples — The Way (GameMaker Studio 2)

Beat-em-up in the spirit of *TMNT: Turtles in Time* (SNES, 1992), themed around
Jesus and the Twelve as portrayed in *The Chosen*. Jesus plays the
Splinter / mentor role; the four playable heroes are Peter, John, James, and
Matthew.

This folder is the **GameMaker Studio 2 source skeleton** for the project. It
sits next to the existing web prototype (`../index.html`) at the repo root.

> **Just want the master to-do list?** Read **[HANDOVER.md](HANDOVER.md)** —
> single document covering every remaining step from IDE wiring through
> animation, audio, and ship.

---

## What's in this drop

A full vertical slice. Engine, content, and most ship-ready systems are
written in GML; only sprite art, audio, and the IDE-side resource wiring are
left for the human pass.

* **Title → character select (1–4 players) → Galilee → Hideout → Wilderness →
  Hideout → Temple → Win → Title.** Save state remembers the last completed
  level and chosen disciple.
* **Four playable disciples**, each with a unique combo, air attack, special
  move, and passive trait (Peter's teammate-protect, John's conversion bonus,
  James's combo trickle, Matthew's blessing-coin drops).
* **Seven enemy archetypes** with distinct AI: Bandit, Roman Guard (block),
  Pharisee (buff aura), Money Changer (drops blessing coins), Centurion
  (telegraphed charge), Barabbas (HP-tier phase-flip mini-boss), False Prophet
  (two-phase ranged → melee), Temple Guard (long spear).
* **Sanctification halo HUD** with gold / white / red tiers, hidden enemy HP
  read through animation cues (winded, staggering, sweat drops), and the
  **prayer / mercy / conversion** mechanic (walk over → convert; attack a
  praying enemy → penalty).
* **Side-scrolling camera** with smooth follow, no-backtrack rule, wave lock,
  and shake on big hits.
* **Story beats** at narrative checkpoints with a styled dialogue box.
* **Hideout hub room** between levels — Jesus seated with the four disciples
  in a torchlit cellar (placeholder draws the layout from your reference
  image).
* **Pause menu** (Esc / Start) with Resume / Restart / Return to Title.
* **Save system** (INI file) — last completed level + selected disciple.
* **Local co-op for up to 4 players.** P1 is keyboard-or-pad-0; P2..P4 join
  by pressing Start on gamepads 1–3.

What's still left:

* **Sprite art** — placeholders are colored rectangles + weapon-prop shapes.
  Aseprite specs are in `HANDOVER.md`.
* **Audio** — no `audio_play_sound` calls yet. Sourcing list is in
  `HANDOVER.md`.
* **IDE wiring** — GameMaker `.yyp` / `.yy` descriptors aren't generated.
  You create the resources in the IDE following the checklist below
  (~45–90 min one-time).

---

## Source layout

```
gamemaker/
├── README.md
├── HANDOVER.md                  ← every remaining step in one doc
├── .gitignore
└── src/
    ├── objects/                 (one folder per object, one .gml per event)
    │   ├── obj_player_base/         Create, Step, Draw
    │   ├── obj_player_peter/        Create
    │   ├── obj_player_john/         Create
    │   ├── obj_player_james/        Create
    │   ├── obj_player_matthew/      Create
    │   ├── obj_enemy_parent/        Create, Step, Draw
    │   ├── obj_enemy_bandit/        Create
    │   ├── obj_enemy_roman/         Create  (block)
    │   ├── obj_enemy_pharisee/      Create  (buff aura)
    │   ├── obj_enemy_money_changer/ Create  (blessing-coin drop)
    │   ├── obj_enemy_centurion/     Create  (charge attack)
    │   ├── obj_enemy_barabbas/      Create  (mini-boss, phase 2)
    │   ├── obj_enemy_false_prophet/ Create  (two-phase boss)
    │   ├── obj_enemy_temple_guard/  Create  (long spear)
    │   ├── obj_coin_projectile/     Create, Step, Draw   (Matthew)
    │   ├── obj_blessing_coin/       Create, Step, Draw   (pickup)
    │   ├── obj_hitbox/              Create, Step
    │   ├── obj_camera/              Create, Step
    │   ├── obj_controller/          Create, Step, Draw GUI
    │   ├── obj_jesus_mentor/        Create, Step, Draw
    │   ├── obj_dialogue_box/        Create, Step, Draw GUI
    │   ├── obj_pause_menu/          Create, Step, Draw GUI
    │   ├── obj_save_manager/        Create  (persistent)
    │   ├── obj_hideout/             Create, Step, Draw GUI
    │   ├── obj_title/               Create, Step, Draw GUI
    │   ├── obj_character_select/    Create, Step, Draw GUI
    │   └── obj_win_screen/          Create, Step, Draw GUI
    ├── scripts/
    │   ├── scr_constants.gml        enums + tunables + halo color
    │   ├── scr_helpers.gml          sanctification, hitbox, halo, input
    │   ├── scr_movesets.gml         all 4 disciple movesets
    │   └── scr_level_system.gml     waves + story beats + level transitions
    ├── rooms/
    │   ├── rm_title/                empty — created in IDE
    │   ├── rm_select/
    │   ├── rm_galilee/              level 1
    │   ├── rm_wilderness/           level 2
    │   ├── rm_temple/               level 3
    │   ├── rm_hideout/              hub between levels
    │   └── rm_win/
    ├── sprites/                     empty named folders, fill in IDE
    └── sounds/                      empty named folders, fill later
```

---

## One-time IDE setup

> Detailed steps with paste-able resource names are in **HANDOVER.md** Phase 1.
> The short version:

1. Create a new GML project in `gamemaker/` named **`DisciplesTheWay`**.
2. For every folder under `src/scripts/`, create a Script resource with the
   matching name and paste the file contents.
3. For every folder under `src/objects/`, create an Object resource. Set the
   parent (player children → `obj_player_base`, enemy children →
   `obj_enemy_parent`). For each `.gml` file in the object folder, add the
   matching event in the IDE and paste.
4. Create rooms `rm_title`, `rm_select`, `rm_galilee`, `rm_wilderness`,
   `rm_temple`, `rm_hideout`, `rm_win`. Set viewport 0 to 640×360.
5. Drop instances:
   - `rm_title`         → `obj_title`
   - `rm_select`        → `obj_character_select`
   - `rm_galilee`, `rm_wilderness`, `rm_temple` → `obj_camera`,
     `obj_controller`, `obj_pause_menu`. Make these rooms ~2400 × 360.
   - `rm_hideout`       → `obj_hideout`
   - `rm_win`           → `obj_win_screen`
6. Game Options → first room: `rm_title`. Toggle `DEBUG_FAST_BOOT` in
   `scr_constants.gml` to skip menus while iterating.
7. Press **F5**. Smoke test in HANDOVER.md, Phase 1.

---

## Linux note

GameMaker Studio 2's stable IDE runs on Windows and macOS. The Linux IDE is
beta-only as of 2026. If you can't get the IDE running on Linux, see
HANDOVER.md "Engine choice" for the Godot 4 / LOVE2D fallback options.
