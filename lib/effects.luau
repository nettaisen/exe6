--!strict
-- One-shot effects many kinds show (`battle.effect(pos, effects.explosion)`):
-- a sprite's animation that plays once. Effects one owner shows live with
-- it.

local big_slash_sprite = asset.sprite("big-slash")
local blast_fire_sprite = asset.sprite("blast-fire")
local blast_sprite = asset.sprite("blast")
local bug_sprite = asset.sprite("bug")
local burst_sprite = asset.sprite("burst")
local buster_up_sprite = asset.sprite("buster-up")
local charge_glow_a_sprite = asset.sprite("charge-glow-a")
local charge_glow_sprite = asset.sprite("charge-glow")
local colonel_effect_sprite = asset.sprite("colonel-effect")
local cross_slash_sprite = asset.sprite("cross-slash")
local deletion_sprite = asset.sprite("deletion")
local diveman_sprite = asset.sprite("diveman")
local dust_2_sprite = asset.sprite("dust-2")
local dust_cloud_sprite = asset.sprite("dust-cloud")
local dust_sprite = asset.sprite("dust")
local dustman_sprite = asset.sprite("dustman")
local effect_55_sprite = asset.sprite("effect-55")
local effect_61_sprite = asset.sprite("effect-61")
local elmnt_ice_sprite = asset.sprite("elmnt-ice")
local energy_burst_sprite = asset.sprite("energy-burst")
local explosion_sprite = asset.sprite("explosion")
local form_change_sprite = asset.sprite("form-change")
local grab_shot_sprite = asset.sprite("grab-shot")
local gregar_cybeast_sprite = asset.sprite("gregar-cybeast")
local ground_drill_effect_sprite = asset.sprite("ground-drill-effect")
local heal_sprite = asset.sprite("heal")
local hit_marker_sprite = asset.sprite("hit-marker")
local hit_sparks_sprite = asset.sprite("hit-sparks")
local hit_sprite = asset.sprite("hit")
local hub_sprite = asset.sprite("hub")
local impact_sprite = asset.sprite("impact")
local lightning_sprite = asset.sprite("lightning")
local lil_boiler_sprite = asset.sprite("lil-boiler")
local moon_blade_sprite = asset.sprite("moon-blade")
local panel_strike_sprite = asset.sprite("panel-strike")
local pink_flash_sprite = asset.sprite("pink-flash")
local puff_sprite = asset.sprite("puff")
local reticle_sprite = asset.sprite("reticle")
local sand_hole_sprite = asset.sprite("sand-hole")
local shell_burst_sprite = asset.sprite("shell-burst")
local sight_sprite = asset.sprite("sight")
local slash_man_effect_sprite = asset.sprite("slash-man-effect")
local small_puff_sprite = asset.sprite("small-puff")
local spout_man_effect_sprite = asset.sprite("spout-man-effect")
local spout_splash_sprite = asset.sprite("spout-splash")
local sun_beam_sprite = asset.sprite("sun-beam")
local swirl_sprite = asset.sprite("swirl")
local sword_slash_sprite = asset.sprite("sword-slash")
local tank_blast_sprite = asset.sprite("tank-blast")
local tornado_sprite = asset.sprite("tornado")
local vulcan_hit_sprite = asset.sprite("vulcan-hit")

local effects = {}

-- An explosion: a blast landing, something breaking (effect 0x00).
effects.explosion = new.effect { sprite = explosion_sprite, anim = 0, palette = 0, steps = 22 }

-- A splash of bubbles: something landing in a hole (effect 0x01).
effects.splash = new.effect { sprite = small_puff_sprite, anim = 0, palette = 0, steps = 16 }

-- Dust: a rock breaking (effect 0x02).
effects.dust = new.effect { sprite = small_puff_sprite, anim = 1, palette = 0, steps = 16 }

-- A puff of smoke: a thrown thing gone when the battle ends, a field
-- object a chip removes (effect 0x14).
effects.puff = new.effect { sprite = puff_sprite, anim = 2, palette = 0, steps = 4 }

-- Bubbles: Otenko's statue breaking (effect 0x02).
effects.bubbles = new.effect { sprite = small_puff_sprite, anim = 1, palette = 0, steps = 16 }

-- A fiery burst: a bullet's (objects/bullet) and TankCan's shell's hit
-- (effect 0x22).
effects.shell_burst = new.effect { sprite = shell_burst_sprite, anim = 0, palette = 0, steps = 27 }

-- A burst: a meteor or a fist landing, a snake striking (effect 0x05).
effects.burst = new.effect { sprite = burst_sprite, anim = 0, palette = 0, steps = 17 }

-- A flash: a gun's shot landing, MegaMan's volley in DblHero, a bullet's
-- burst (objects/bullet's rows 0 to 3) (effect 0x21).
effects.flash = new.effect { sprite = pink_flash_sprite, anim = 0, palette = 0, steps = 10 }

-- A small splash: something diving into or out of the field (effect 0x02:
-- the dragons).
effects.ripple = new.effect { sprite = small_puff_sprite, anim = 1, palette = 0, steps = 16 }

-- A burst of smoke: a train car blowing up, a navi coming or going in a
-- puff (effect 0x12).
effects.smoke = new.effect { sprite = puff_sprite, anim = 0, palette = 0, steps = 4 }

-- The rest of the original's effects (gen-content).
-- Effect 0x03.
effects.deletion = new.effect { sprite = deletion_sprite, anim = 0, palette = 0, steps = 22 }
-- Effect 0x04.
effects.ground_drill_effect = new.effect { sprite = ground_drill_effect_sprite, anim = 0, palette = 0, steps = 1 }
-- Effect 0x06.
effects.heal = new.effect { sprite = heal_sprite, anim = 0, palette = 0, steps = 14 }
-- Effect 0x07.
effects.copy_mark = new.effect { sprite = hit_sparks_sprite, anim = 0, palette = 0, steps = 4 }
-- Effect 0x08.
effects.copy_mark_2 = new.effect { sprite = hit_sparks_sprite, anim = 2, palette = 0, steps = 15 }
-- Effect 0x09.
effects.copy_mark_3 = new.effect { sprite = hit_sparks_sprite, anim = 3, palette = 0, steps = 11 }
-- Effect 0x0A.
effects.copy_mark_4 = new.effect { sprite = hit_sparks_sprite, anim = 4, palette = 0, steps = 12 }
-- Effect 0x0B.
effects.copy_mark_5 = new.effect { sprite = hit_sparks_sprite, anim = 5, palette = 0, steps = 13 }
-- Effect 0x0C.
effects.copy_mark_1 = new.effect { sprite = hit_sparks_sprite, anim = 1, palette = 0, steps = 8 }
-- Effect 0x0D.
effects.copy_mark_9 = new.effect { sprite = hit_sparks_sprite, anim = 9, palette = 0, steps = 3 }
-- Effect 0x0E.
effects.impact = new.effect { sprite = impact_sprite, anim = 0, palette = 0, steps = 19 }
-- Effect 0x0F.
effects.hit = new.effect { sprite = hit_sprite, anim = 0, palette = 0, steps = 9 }
-- Effect 0x10.
effects.reflected_shot_1 = new.effect { sprite = pink_flash_sprite, anim = 1, palette = 0, steps = 12 }
-- Effect 0x13.
effects.puff_1 = new.effect { sprite = puff_sprite, anim = 1, palette = 0, steps = 4 }
-- Effect 0x15.
effects.puff_3 = new.effect { sprite = puff_sprite, anim = 3, palette = 0, steps = 4 }
-- Effect 0x16.
effects.sword_slash = new.effect { sprite = sword_slash_sprite, anim = 0, palette = 0, steps = 13 }
-- Effect 0x17.
effects.sword_slash_1 = new.effect { sprite = sword_slash_sprite, anim = 1, palette = 0, steps = 13 }
-- Effect 0x18.
effects.sword_slash_2 = new.effect { sprite = sword_slash_sprite, anim = 2, palette = 0, steps = 10 }
-- Effect 0x19.
effects.sword_slash_19 = new.effect { sprite = sword_slash_sprite, anim = 0, palette = 5, steps = 13 }
-- Effect 0x1A.
effects.sword_slash_1_1a = new.effect { sprite = sword_slash_sprite, anim = 1, palette = 5, steps = 13 }
-- Effect 0x1B.
effects.big_slash = new.effect { sprite = big_slash_sprite, anim = 0, palette = 0, steps = 15 }
-- Effect 0x1C.
effects.big_slash_1c = new.effect { sprite = big_slash_sprite, anim = 0, palette = 2, steps = 15 }
-- Effect 0x1E.
effects.cut_in_flash = new.effect { sprite = hit_marker_sprite, anim = 0, palette = 0, steps = 18 }
-- Effect 0x1F.
effects.spout_splash = new.effect { sprite = spout_splash_sprite, anim = 0, palette = 0, steps = 31 }
-- Effect 0x20.
effects.vulcan_hit = new.effect { sprite = vulcan_hit_sprite, anim = 0, palette = 0, steps = 10 }
-- Effect 0x23.
effects.energy_burst = new.effect { sprite = energy_burst_sprite, anim = 0, palette = 1, steps = 32 }
-- Effect 0x24.
effects.explosion_24 = new.effect { sprite = explosion_sprite, anim = 0, palette = 1, steps = 22 }
-- Effect 0x25.
effects.sword_slash_3 = new.effect { sprite = sword_slash_sprite, anim = 3, palette = 0, steps = 13 }
-- Effect 0x26.
effects.elmnt_ice = new.effect { sprite = elmnt_ice_sprite, anim = 0, palette = 0, steps = 16 }
-- Effect 0x28.
effects.copy_mark_11 = new.effect { sprite = hit_sparks_sprite, anim = 11, palette = 1, steps = 20 }
-- Effect 0x29.
effects.blast_fire_12 = new.effect { sprite = blast_fire_sprite, anim = 12, palette = 0, steps = 9 }
-- Effect 0x2A.
effects.spout_man_effect = new.effect { sprite = spout_man_effect_sprite, anim = 0, palette = 0, steps = 12 }
-- Effect 0x2B.
effects.diveman_21 = new.effect { sprite = diveman_sprite, anim = 21, palette = 0, steps = 14 }
-- Effect 0x2C.
effects.diveman_25 = new.effect { sprite = diveman_sprite, anim = 25, palette = 0, steps = 12 }
-- Effect 0x2D.
effects.sword_slash_1_2d = new.effect { sprite = sword_slash_sprite, anim = 1, palette = 6, steps = 13 }
-- Effect 0x2E.
effects.form_change = new.effect { sprite = form_change_sprite, anim = 0, palette = 0, steps = 12 }
-- Effect 0x2F.
effects.reticle = new.effect { sprite = reticle_sprite, anim = 0, palette = 0, steps = 14 }
-- Effect 0x30.
effects.dust_2 = new.effect { sprite = dust_sprite, anim = 0, palette = 0, steps = 17 }
-- Effect 0x31.
effects.buster_up = new.effect { sprite = buster_up_sprite, anim = 0, palette = 0, steps = 17 }
-- Effect 0x32.
effects.lil_boiler_10 = new.effect { sprite = lil_boiler_sprite, anim = 10, palette = 0, steps = 20 }
-- Effect 0x33.
effects.big_slash_1 = new.effect { sprite = big_slash_sprite, anim = 1, palette = 0, steps = 12 }
-- Effect 0x34.
effects.dust_2_2 = new.effect { sprite = dust_2_sprite, anim = 0, palette = 0, steps = 14 }
-- Effect 0x35.
effects.colonel_effect = new.effect { sprite = colonel_effect_sprite, anim = 0, palette = 0, steps = 13 }
-- Effect 0x36.
effects.colonel_effect_1 = new.effect { sprite = colonel_effect_sprite, anim = 1, palette = 0, steps = 13 }
-- Effect 0x37.
effects.colonel_effect_2 = new.effect { sprite = colonel_effect_sprite, anim = 2, palette = 0, steps = 13 }
-- Effect 0x38.
effects.colonel_effect_3 = new.effect { sprite = colonel_effect_sprite, anim = 3, palette = 0, steps = 16 }
-- Effect 0x39.
effects.slash_man_effect = new.effect { sprite = slash_man_effect_sprite, anim = 0, palette = 0, steps = 11 }
-- Effect 0x3A.
effects.slash_man_effect_1 = new.effect { sprite = slash_man_effect_sprite, anim = 1, palette = 0, steps = 11 }
-- Effect 0x3B.
effects.grab_shot_1 = new.effect { sprite = grab_shot_sprite, anim = 1, palette = 0, steps = 16 }
-- Effect 0x3C.
effects.grab_shot_1_3c = new.effect { sprite = grab_shot_sprite, anim = 1, palette = 8, steps = 16 }
-- Effect 0x3D.
effects.reflected_shot_3d = new.effect { sprite = pink_flash_sprite, anim = 0, palette = 2, steps = 10 }
-- Effect 0x3E.
effects.beast_over_blast = new.effect { sprite = form_change_sprite, anim = 1, palette = 0, steps = 12 }
-- Effect 0x3F.
effects.beast_over_gregar = new.effect { sprite = form_change_sprite, anim = 2, palette = 0, steps = 12 }
-- Effect 0x40.
effects.beast_over_falzar = new.effect { sprite = form_change_sprite, anim = 3, palette = 0, steps = 12 }
-- Effect 0x41.
effects.swirl_1 = new.effect { sprite = swirl_sprite, anim = 1, palette = 1, steps = 15 }
-- Effect 0x43.
effects.moon_blade = new.effect { sprite = moon_blade_sprite, anim = 0, palette = 0, steps = 10 }
-- Effect 0x44.
effects.swirl = new.effect { sprite = swirl_sprite, anim = 0, palette = 0, steps = 24 }
-- Effect 0x45.
effects.beast_over_burst = new.effect { sprite = lightning_sprite, anim = 0, palette = 0, steps = 17 }
-- Effect 0x46.
effects.trap_mark = new.effect { sprite = hit_sparks_sprite, anim = 7, palette = 0, steps = 24 }
-- Effect 0x47.
effects.blast = new.effect { sprite = blast_sprite, anim = 0, palette = 0, steps = 18 }
-- Effect 0x48.
effects.copy_mark_12 = new.effect { sprite = hit_sparks_sprite, anim = 12, palette = 0, steps = 1 }
-- Effect 0x49.
effects.sight = new.effect { sprite = sight_sprite, anim = 0, palette = 0, steps = 21 }
-- Effect 0x4A.
effects.explosion_4a = new.effect { sprite = explosion_sprite, anim = 0, palette = 2, steps = 22 }
-- Effect 0x4B (a look of Gregar the Cybeast's sheet, which the Falzar ROMs
-- have a placeholder for).
effects.gregar_cybeast_82 = new.effect { sprite = gregar_cybeast_sprite, anim = 82, palette = 16, steps = 7 }
-- Effect 0x4C.
effects.slash_man_effect_2 = new.effect { sprite = slash_man_effect_sprite, anim = 2, palette = 0, steps = 11 }
-- Effect 0x4D (an animation past the sheet's last: it goes after one step).
effects.slash_man_effect_3 = new.effect { sprite = slash_man_effect_sprite, anim = 3, palette = 0, steps = 1 }
-- Effect 0x4E.
effects.charge_glow = new.effect { sprite = charge_glow_sprite, anim = 0, palette = 0, steps = 16 }
-- Effect 0x4F.
effects.charge_glow_2 = new.effect { sprite = charge_glow_sprite, anim = 2, palette = 0, steps = 16 }
-- Effect 0x50.
effects.sand_hole = new.effect { sprite = sand_hole_sprite, anim = 0, palette = 0, steps = 24 }
-- Effect 0x51.
effects.dustman_24 = new.effect { sprite = dustman_sprite, anim = 24, palette = 0, steps = 36 }
-- Effect 0x52.
effects.cross_slash = new.effect { sprite = cross_slash_sprite, anim = 0, palette = 0, steps = 11 }
-- Effect 0x53.
effects.copy_mark_1_53 = new.effect { sprite = hit_sparks_sprite, anim = 1, palette = 6, steps = 8 }
-- Effect 0x54.
effects.panel_strike = new.effect { sprite = panel_strike_sprite, anim = 0, palette = 0, steps = 12 }
-- Effect 0x55.
effects.effect_55_12 = new.effect { sprite = effect_55_sprite, anim = 12, palette = 0, steps = 14 }
-- Effect 0x56.
effects.sight_4 = new.effect { sprite = sight_sprite, anim = 4, palette = 0, steps = 32 }
-- Effect 0x57.
effects.copy_mark_8 = new.effect { sprite = hit_sparks_sprite, anim = 8, palette = 0, steps = 4 }
-- Effect 0x58.
effects.reticle_1 = new.effect { sprite = reticle_sprite, anim = 1, palette = 0, steps = 10 }
-- Effect 0x59.
effects.tornado = new.effect { sprite = tornado_sprite, anim = 0, palette = 0, steps = 6 }
-- Effect 0x5A.
effects.hub = new.effect { sprite = hub_sprite, anim = 0, palette = 0, steps = 43 }
-- Effect 0x5B.
effects.bug = new.effect { sprite = bug_sprite, anim = 0, palette = 0, steps = 41 }
-- Effect 0x5C.
effects.charge_glow_a_3 = new.effect { sprite = charge_glow_a_sprite, anim = 3, palette = 1, steps = 22 }
-- Effect 0x5D.
effects.sun_beam = new.effect { sprite = sun_beam_sprite, anim = 0, palette = 0, steps = 10 }
-- Effect 0x5E.
effects.dustman_30 = new.effect { sprite = dustman_sprite, anim = 30, palette = 0, steps = 18 }
-- Effect 0x60.
effects.tank_blast = new.effect { sprite = tank_blast_sprite, anim = 0, palette = 0, steps = 17 }
-- Effect 0x61.
effects.effect_61 = new.effect { sprite = effect_61_sprite, anim = 0, palette = 0, steps = 15 }
-- Effect 0x62.
effects.colonel_effect_5 = new.effect { sprite = colonel_effect_sprite, anim = 5, palette = 0, steps = 25 }
-- Effect 0x63.
effects.dust_cloud = new.effect { sprite = dust_cloud_sprite, anim = 0, palette = 0, steps = 18 }
-- Effect 0x64.
effects.sword_slash_64 = new.effect { sprite = sword_slash_sprite, anim = 0, palette = 6, steps = 13 }
-- Effect 0x65.
effects.sword_slash_1_65 = new.effect { sprite = sword_slash_sprite, anim = 1, palette = 4, steps = 13 }
-- Effect 0x66.
effects.sword_slash_66 = new.effect { sprite = sword_slash_sprite, anim = 0, palette = 4, steps = 13 }
-- Effect 0x67.
effects.sword_slash_3_67 = new.effect { sprite = sword_slash_sprite, anim = 3, palette = 4, steps = 13 }
-- Effect 0x69.
effects.hub_1 = new.effect { sprite = hub_sprite, anim = 1, palette = 0, steps = 33 }
-- Effect 0x6A.
effects.vulcan_hit_6a = new.effect { sprite = vulcan_hit_sprite, anim = 0, palette = 1, steps = 10 }

return effects
