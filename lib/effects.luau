--!strict
-- One-shot effects many kinds show (`battle.effect(pos, effects.explosion)`):
-- a sprite's animation that plays once. Effects one owner shows live with
-- it.

local big_slash_sprite = require("../sprites/big_slash")
local blast_fire_sprite = require("../sprites/blast_fire")
local blast_sprite = require("../sprites/blast")
local bug_sprite = require("../sprites/bug")
local burst_sprite = require("../sprites/burst")
local buster_up_sprite = require("../chips/busterup/buster_up_sprite")
local charge_glow_a_sprite = require("../sprites/charge_glow_a")
local charge_glow_sprite = require("../sprites/charge_glow")
local colonel_effect_sprite = require("../sprites/colonel_effect")
local cross_slash_sprite = require("../sprites/cross_slash")
local deletion_sprite = require("../sprites/deletion")
local diveman_sprite = require("../chips/diveman/diveman_sprite")
local dust_2_sprite = require("../sprites/dust_2")
local dust_cloud_sprite = require("../sprites/dust_cloud")
local dust_sprite = require("../sprites/dust")
local dustman_sprite = require("../navis/dustman/dustman_sprite")
local effect_55_sprite = require("../sprites/effect_55")
local effect_61_sprite = require("../sprites/effect_61")
local elmnt_ice_sprite = require("../sprites/elmnt_ice")
local energy_burst_sprite = require("../sprites/energy_burst")
local explosion_sprite = require("../sprites/explosion")
local form_change_sprite = require("../sprites/form_change")
local grab_shot_sprite = require("../sprites/grab_shot")
local gregar_cybeast_sprite = require("../sprites/gregar_cybeast")
local ground_drill_effect_sprite = require("../sprites/ground_drill_effect")
local heal_sprite = require("../sprites/heal")
local hit_marker_sprite = require("../sprites/hit_marker")
local hit_sparks_sprite = require("../sprites/hit_sparks")
local hit_sprite = require("../sprites/hit")
local hub_sprite = require("../sprites/hub")
local impact_sprite = require("../sprites/impact")
local lightning_sprite = require("../sprites/lightning")
local lil_boiler_sprite = require("../sprites/lil_boiler")
local moon_blade_sprite = require("../sprites/moon_blade")
local panel_strike_sprite = require("../objects/panel_strike/panel_strike_sprite")
local pink_flash_sprite = require("../sprites/pink_flash")
local puff_sprite = require("../sprites/puff")
local reticle_sprite = require("../sprites/reticle")
local sand_hole_sprite = require("../sprites/sand_hole")
local shell_burst_sprite = require("../sprites/shell_burst")
local sight_sprite = require("../sprites/sight")
local slash_man_effect_sprite = require("../sprites/slash_man_effect")
local small_puff_sprite = require("../sprites/small_puff")
local spout_man_effect_sprite = require("../sprites/spout_man_effect")
local spout_splash_sprite = require("../sprites/spout_splash")
local sun_beam_sprite = require("../sprites/sun_beam")
local swirl_sprite = require("../sprites/swirl")
local sword_slash_sprite = require("../sprites/sword_slash")
local tank_blast_sprite = require("../sprites/tank_blast")
local tornado_sprite = require("../chips/tornado/tornado_sprite")
local vulcan_hit_sprite = require("../sprites/vulcan_hit")

local effects = {}

-- An explosion: a blast landing, something breaking (effect 0x00).
effects.explosion = new.effect { sprite = explosion_sprite, anim = 0, palette = 0 }

-- A splash of bubbles: something landing in a hole (effect 0x01).
effects.splash = new.effect { sprite = small_puff_sprite, anim = 0, palette = 0 }

-- Dust: a rock breaking (effect 0x02).
effects.dust = new.effect { sprite = small_puff_sprite, anim = 1, palette = 0 }

-- A puff of smoke: a thrown thing gone when the battle ends, a field
-- object a chip removes (effect 0x14).
effects.puff = new.effect { sprite = puff_sprite, anim = 2, palette = 0 }

-- Bubbles: Otenko's statue breaking (effect 0x02).
effects.bubbles = new.effect { sprite = small_puff_sprite, anim = 1, palette = 0 }

-- A fiery burst: a bullet's (objects/bullet) and TankCan's shell's hit
-- (effect 0x22).
effects.shell_burst = new.effect { sprite = shell_burst_sprite, anim = 0, palette = 0 }

-- A burst: a meteor or a fist landing, a snake striking (effect 0x05).
effects.burst = new.effect { sprite = burst_sprite, anim = 0, palette = 0 }

-- A flash: a gun's shot landing, MegaMan's volley in DblHero, a bullet's
-- burst (objects/bullet's rows 0 to 3) (effect 0x21).
effects.flash = new.effect { sprite = pink_flash_sprite, anim = 0, palette = 0 }

-- A small splash: something diving into or out of the field (effect 0x02:
-- the dragons).
effects.ripple = new.effect { sprite = small_puff_sprite, anim = 1, palette = 0 }

-- A burst of smoke: a train car blowing up, a navi coming or going in a
-- puff (effect 0x12).
effects.smoke = new.effect { sprite = puff_sprite, anim = 0, palette = 0 }

-- The rest of the original's effects (gen-content).
-- Effect 0x03.
effects.deletion = new.effect { sprite = deletion_sprite, anim = 0, palette = 0 }
-- Effect 0x04.
effects.ground_drill_effect = new.effect { sprite = ground_drill_effect_sprite, anim = 0, palette = 0 }
-- Effect 0x06.
effects.heal = new.effect { sprite = heal_sprite, anim = 0, palette = 0 }
-- Effect 0x07.
effects.copy_mark = new.effect { sprite = hit_sparks_sprite, anim = 0, palette = 0 }
-- Effect 0x08.
effects.copy_mark_2 = new.effect { sprite = hit_sparks_sprite, anim = 2, palette = 0 }
-- Effect 0x09.
effects.copy_mark_3 = new.effect { sprite = hit_sparks_sprite, anim = 3, palette = 0 }
-- Effect 0x0A.
effects.copy_mark_4 = new.effect { sprite = hit_sparks_sprite, anim = 4, palette = 0 }
-- Effect 0x0B.
effects.copy_mark_5 = new.effect { sprite = hit_sparks_sprite, anim = 5, palette = 0 }
-- Effect 0x0C.
effects.copy_mark_1 = new.effect { sprite = hit_sparks_sprite, anim = 1, palette = 0 }
-- Effect 0x0D.
effects.copy_mark_9 = new.effect { sprite = hit_sparks_sprite, anim = 9, palette = 0 }
-- Effect 0x0E.
effects.impact = new.effect { sprite = impact_sprite, anim = 0, palette = 0 }
-- Effect 0x0F.
effects.hit = new.effect { sprite = hit_sprite, anim = 0, palette = 0 }
-- Effect 0x10.
effects.reflected_shot_1 = new.effect { sprite = pink_flash_sprite, anim = 1, palette = 0 }
-- Effect 0x13.
effects.puff_1 = new.effect { sprite = puff_sprite, anim = 1, palette = 0 }
-- Effect 0x15.
effects.puff_3 = new.effect { sprite = puff_sprite, anim = 3, palette = 0 }
-- Effect 0x16.
effects.sword_slash = new.effect { sprite = sword_slash_sprite, anim = 0, palette = 0 }
-- Effect 0x17.
effects.sword_slash_1 = new.effect { sprite = sword_slash_sprite, anim = 1, palette = 0 }
-- Effect 0x18.
effects.sword_slash_2 = new.effect { sprite = sword_slash_sprite, anim = 2, palette = 0 }
-- Effect 0x19.
effects.sword_slash_19 = new.effect { sprite = sword_slash_sprite, anim = 0, palette = 5 }
-- Effect 0x1A.
effects.sword_slash_1_1a = new.effect { sprite = sword_slash_sprite, anim = 1, palette = 5 }
-- Effect 0x1B.
effects.big_slash = new.effect { sprite = big_slash_sprite, anim = 0, palette = 0 }
-- Effect 0x1C.
effects.big_slash_1c = new.effect { sprite = big_slash_sprite, anim = 0, palette = 2 }
-- Effect 0x1E.
effects.cut_in_flash = new.effect { sprite = hit_marker_sprite, anim = 0, palette = 0 }
-- Effect 0x1F.
effects.spout_splash = new.effect { sprite = spout_splash_sprite, anim = 0, palette = 0 }
-- Effect 0x20.
effects.vulcan_hit = new.effect { sprite = vulcan_hit_sprite, anim = 0, palette = 0 }
-- Effect 0x23.
effects.energy_burst = new.effect { sprite = energy_burst_sprite, anim = 0, palette = 1 }
-- Effect 0x24.
effects.explosion_24 = new.effect { sprite = explosion_sprite, anim = 0, palette = 1 }
-- Effect 0x25.
effects.sword_slash_3 = new.effect { sprite = sword_slash_sprite, anim = 3, palette = 0 }
-- Effect 0x26.
effects.elmnt_ice = new.effect { sprite = elmnt_ice_sprite, anim = 0, palette = 0 }
-- Effect 0x28.
effects.copy_mark_11 = new.effect { sprite = hit_sparks_sprite, anim = 11, palette = 1 }
-- Effect 0x29.
effects.blast_fire_12 = new.effect { sprite = blast_fire_sprite, anim = 12, palette = 0 }
-- Effect 0x2A.
effects.spout_man_effect = new.effect { sprite = spout_man_effect_sprite, anim = 0, palette = 0 }
-- Effect 0x2B.
effects.diveman_21 = new.effect { sprite = diveman_sprite, anim = 21, palette = 0 }
-- Effect 0x2C.
effects.diveman_25 = new.effect { sprite = diveman_sprite, anim = 25, palette = 0 }
-- Effect 0x2D.
effects.sword_slash_1_2d = new.effect { sprite = sword_slash_sprite, anim = 1, palette = 6 }
-- Effect 0x2E.
effects.form_change = new.effect { sprite = form_change_sprite, anim = 0, palette = 0 }
-- Effect 0x2F.
effects.reticle = new.effect { sprite = reticle_sprite, anim = 0, palette = 0 }
-- Effect 0x30.
effects.dust_2 = new.effect { sprite = dust_sprite, anim = 0, palette = 0 }
-- Effect 0x31.
effects.buster_up = new.effect { sprite = buster_up_sprite, anim = 0, palette = 0 }
-- Effect 0x32.
effects.lil_boiler_10 = new.effect { sprite = lil_boiler_sprite, anim = 10, palette = 0 }
-- Effect 0x33.
effects.big_slash_1 = new.effect { sprite = big_slash_sprite, anim = 1, palette = 0 }
-- Effect 0x34.
effects.dust_2_2 = new.effect { sprite = dust_2_sprite, anim = 0, palette = 0 }
-- Effect 0x35.
effects.colonel_effect = new.effect { sprite = colonel_effect_sprite, anim = 0, palette = 0 }
-- Effect 0x36.
effects.colonel_effect_1 = new.effect { sprite = colonel_effect_sprite, anim = 1, palette = 0 }
-- Effect 0x37.
effects.colonel_effect_2 = new.effect { sprite = colonel_effect_sprite, anim = 2, palette = 0 }
-- Effect 0x38.
effects.colonel_effect_3 = new.effect { sprite = colonel_effect_sprite, anim = 3, palette = 0 }
-- Effect 0x39.
effects.slash_man_effect = new.effect { sprite = slash_man_effect_sprite, anim = 0, palette = 0 }
-- Effect 0x3A.
effects.slash_man_effect_1 = new.effect { sprite = slash_man_effect_sprite, anim = 1, palette = 0 }
-- Effect 0x3B.
effects.grab_shot_1 = new.effect { sprite = grab_shot_sprite, anim = 1, palette = 0 }
-- Effect 0x3C.
effects.grab_shot_1_3c = new.effect { sprite = grab_shot_sprite, anim = 1, palette = 8 }
-- Effect 0x3D.
effects.reflected_shot_3d = new.effect { sprite = pink_flash_sprite, anim = 0, palette = 2 }
-- Effect 0x3E.
effects.beast_over_blast = new.effect { sprite = form_change_sprite, anim = 1, palette = 0 }
-- Effect 0x3F.
effects.beast_over_gregar = new.effect { sprite = form_change_sprite, anim = 2, palette = 0 }
-- Effect 0x40.
effects.beast_over_falzar = new.effect { sprite = form_change_sprite, anim = 3, palette = 0 }
-- Effect 0x41.
effects.swirl_1 = new.effect { sprite = swirl_sprite, anim = 1, palette = 1 }
-- Effect 0x43.
effects.moon_blade = new.effect { sprite = moon_blade_sprite, anim = 0, palette = 0 }
-- Effect 0x44.
effects.swirl = new.effect { sprite = swirl_sprite, anim = 0, palette = 0 }
-- Effect 0x45.
effects.beast_over_burst = new.effect { sprite = lightning_sprite, anim = 0, palette = 0 }
-- Effect 0x46.
effects.trap_mark = new.effect { sprite = hit_sparks_sprite, anim = 7, palette = 0 }
-- Effect 0x47.
effects.blast = new.effect { sprite = blast_sprite, anim = 0, palette = 0 }
-- Effect 0x48.
effects.copy_mark_12 = new.effect { sprite = hit_sparks_sprite, anim = 12, palette = 0 }
-- Effect 0x49.
effects.sight = new.effect { sprite = sight_sprite, anim = 0, palette = 0 }
-- Effect 0x4A.
effects.explosion_4a = new.effect { sprite = explosion_sprite, anim = 0, palette = 2 }
-- Effect 0x4B (a look of Gregar the Cybeast's sheet, which the Falzar ROMs
-- have a placeholder for).
effects.gregar_cybeast_82 = new.effect { sprite = gregar_cybeast_sprite, anim = 82, palette = 16 }
-- Effect 0x4C.
effects.slash_man_effect_2 = new.effect { sprite = slash_man_effect_sprite, anim = 2, palette = 0 }
-- Effect 0x4D.
effects.slash_man_effect_3 = new.effect { sprite = slash_man_effect_sprite, anim = 3, palette = 0 }
-- Effect 0x4E.
effects.charge_glow = new.effect { sprite = charge_glow_sprite, anim = 0, palette = 0 }
-- Effect 0x4F.
effects.charge_glow_2 = new.effect { sprite = charge_glow_sprite, anim = 2, palette = 0 }
-- Effect 0x50.
effects.sand_hole = new.effect { sprite = sand_hole_sprite, anim = 0, palette = 0 }
-- Effect 0x51.
effects.dustman_24 = new.effect { sprite = dustman_sprite, anim = 24, palette = 0 }
-- Effect 0x52.
effects.cross_slash = new.effect { sprite = cross_slash_sprite, anim = 0, palette = 0 }
-- Effect 0x53.
effects.copy_mark_1_53 = new.effect { sprite = hit_sparks_sprite, anim = 1, palette = 6 }
-- Effect 0x54.
effects.panel_strike = new.effect { sprite = panel_strike_sprite, anim = 0, palette = 0 }
-- Effect 0x55.
effects.effect_55_12 = new.effect { sprite = effect_55_sprite, anim = 12, palette = 0 }
-- Effect 0x56.
effects.sight_4 = new.effect { sprite = sight_sprite, anim = 4, palette = 0 }
-- Effect 0x57.
effects.copy_mark_8 = new.effect { sprite = hit_sparks_sprite, anim = 8, palette = 0 }
-- Effect 0x58.
effects.reticle_1 = new.effect { sprite = reticle_sprite, anim = 1, palette = 0 }
-- Effect 0x59.
effects.tornado = new.effect { sprite = tornado_sprite, anim = 0, palette = 0 }
-- Effect 0x5A.
effects.hub = new.effect { sprite = hub_sprite, anim = 0, palette = 0 }
-- Effect 0x5B.
effects.bug = new.effect { sprite = bug_sprite, anim = 0, palette = 0 }
-- Effect 0x5C.
effects.charge_glow_a_3 = new.effect { sprite = charge_glow_a_sprite, anim = 3, palette = 1 }
-- Effect 0x5D.
effects.sun_beam = new.effect { sprite = sun_beam_sprite, anim = 0, palette = 0 }
-- Effect 0x5E.
effects.dustman_30 = new.effect { sprite = dustman_sprite, anim = 30, palette = 0 }
-- Effect 0x60.
effects.tank_blast = new.effect { sprite = tank_blast_sprite, anim = 0, palette = 0 }
-- Effect 0x61.
effects.effect_61 = new.effect { sprite = effect_61_sprite, anim = 0, palette = 0 }
-- Effect 0x62.
effects.colonel_effect_5 = new.effect { sprite = colonel_effect_sprite, anim = 5, palette = 0 }
-- Effect 0x63.
effects.dust_cloud = new.effect { sprite = dust_cloud_sprite, anim = 0, palette = 0 }
-- Effect 0x64.
effects.sword_slash_64 = new.effect { sprite = sword_slash_sprite, anim = 0, palette = 6 }
-- Effect 0x65.
effects.sword_slash_1_65 = new.effect { sprite = sword_slash_sprite, anim = 1, palette = 4 }
-- Effect 0x66.
effects.sword_slash_66 = new.effect { sprite = sword_slash_sprite, anim = 0, palette = 4 }
-- Effect 0x67.
effects.sword_slash_3_67 = new.effect { sprite = sword_slash_sprite, anim = 3, palette = 4 }
-- Effect 0x69.
effects.hub_1 = new.effect { sprite = hub_sprite, anim = 1, palette = 0 }
-- Effect 0x6A.
effects.vulcan_hit_6a = new.effect { sprite = vulcan_hit_sprite, anim = 0, palette = 1 }

return effects
