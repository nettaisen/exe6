--!strict
-- Collision types (docs/engine/field-collision-damage.md §3.3): what an
-- object is (its self type) and what it reaches (its target type), as a
-- flag word for each side. An object's registration takes two
-- (`me:setup_collision(is, hits, hit_mod)`).
--
-- Each type's row of the original's table (`byte_8019C7C`) is compat's
-- (rules.toml, `collision_types`).
--
-- The types the converted content uses so far; the generator adds the
-- rest (docs/design/content-model-v2.md §9.3). Names other than `thrown`
-- and `hits-navis` (the design's) were made up by what the flags do; they
-- are listed there for review.

local collision = {}

-- An attack of its side that also reaches objects with status 0x20 (row
-- 0x04: a seed, a bomb's lingering hit, the bug and black bombs' bursts).
collision.attack = new.collision { flags = { own_attack = true, reaches_float_shoe = true } }

-- A thrown attack (row 0x0A: a bomb, a FlashBomb in flight, the energy
-- burst's hits).
collision.thrown = new.collision { flags = { own_attack = true, reaches_float_shoe = true, reaches_submerged = true } }

-- A slash (row 0x07: the swords' hits).
collision.slash = new.collision { flags = { own_attack = true, sword = true, reaches_float_shoe = true } }

-- A thrown slash (row 0x1C: AntiDmg's and BodyGrd's shurikens).
collision.thrown_slash = new.collision {
    flags = { own_attack = true, sword = true, reaches_float_shoe = true, reaches_submerged = true },
}

-- An attack that pierces invisibility and flashing (row 0x0B: the
-- FlashBomb's flash).
collision.piercing = new.collision { flags = { own_attack = true, reaches_float_shoe = true, piercing = true } }

-- What reaches the other side's objects, bodies and neutral objects: a
-- navi's attacks' target (row 0x05).
collision.hits_navis = new.collision {
    flags = { enemy_object = true, enemy_body = true, enemy_other_body = true, neutral = true },
}

-- What reaches the other side's attacks, objects and bodies and neutral
-- objects (row 0x14: a BugBomb sitting); with the blocker bit, a
-- FlashBomb set down (row 0x0D).
collision.hit_by_other_side = new.collision {
    flags = { enemy_attack = true, enemy_object = true, enemy_body = true, enemy_other_body = true, neutral = true },
}
collision.hit_by_other_side_or_blockers = new.collision {
    flags = {
        enemy_attack = true,
        enemy_object = true,
        enemy_body = true,
        enemy_other_body = true,
        neutral = true,
        reaches_set_objects = true,
    },
}

-- An attack that pierces invisibility and flashing and breaks guards and
-- ice (row 0x16: the erase beams, Sensor's laser).
collision.piercing_break = new.collision {
    flags = { own_attack = true, reaches_float_shoe = true, piercing = true, ["break"] = true },
}

-- An object of its side, while dimmed too (row 0x0C: a FlashBomb set
-- down).
collision.own_object = new.collision {
    flags = { own_object = true, hits_while_dimmed = true, reaches_float_shoe = true },
}

-- Another body of its side that a thrown attack reaches, while dimmed too
-- (row 0x4E: a BugBomb sitting).
collision.own_thrown_body = new.collision {
    flags = { own_other_body = true, hits_while_dimmed = true, reaches_float_shoe = true, reaches_submerged = true },
}

-- A neutral object, while dimmed too (row 0x4F: a BlkBomb).
collision.neutral_object = new.collision {
    flags = {
        neutral = true,
        hits_while_dimmed = true,
        reaches_float_shoe = true,
        reaches_submerged = true,
        ["break"] = true,
    },
}

-- What reaches everything: attacks, objects and bodies of both sides and
-- neutral objects (row 0x0F: what a BlkBomb reacts to).
collision.everything = new.collision {
    flags = {
        own_attack = true,
        enemy_attack = true,
        own_object = true,
        enemy_object = true,
        own_body = true,
        enemy_body = true,
        own_other_body = true,
        enemy_other_body = true,
        neutral = true,
        ["break"] = true,
    },
}

-- What reaches the other side's attacks and objects (row 0x18: ElemTrap's
-- trap, which feels the other side's hits wherever they land).
collision.hit_by_other_attacks = new.collision { flags = { enemy_attack = true, enemy_object = true } }

-- A mine: an attack of both sides that pierces invisibility and flashing
-- and breaks guards (row 0x33: an armed land mine); and what it reaches,
-- objects and bodies of both sides, the other side's other bodies and
-- neutral objects (row 0x2A).
collision.mine = new.collision {
    flags = {
        own_attack = true,
        enemy_attack = true,
        reaches_set_objects = true,
        reaches_submerged = true,
        piercing = true,
        ["break"] = true,
    },
}
collision.hits_both_sides = new.collision {
    flags = {
        own_object = true,
        enemy_object = true,
        own_body = true,
        enemy_body = true,
        enemy_other_body = true,
        neutral = true,
    },
}

-- The navi chips' and link navis' types (named by what their flags add
-- to an attack's: 0x02 breaks guards and ice; 0x04 pierces invisibility
-- and flashing; 0x08 as a thrown attack's).

-- A navi's body (row 0x01), and what a navi hits (row 0x02).
collision.navi = new.collision {
    flags = { own_body = true, own_navi = true, hits_while_dimmed = true, reaches_float_shoe = true },
}
collision.navi_target = new.collision {
    flags = {
        enemy_attack = true,
        enemy_object = true,
        enemy_body = true,
        enemy_other_body = true,
        neutral = true,
        pull = true,
    },
}

-- A navi's body with FloatShoes (row 0x10: a navi's body that floats; what
-- HubBatc leaves its navi).
collision.floating_navi = new.collision {
    flags = { own_body = true, own_navi = true, floating = true, hits_while_dimmed = true, reaches_float_shoe = true },
}

-- A thrown attack that breaks (row 0x15: GroundMan's drill and rocks,
-- MetrKnuk's fists, GolmHit's golem landing, JustcOne's fist, a falling
-- rock).
collision.thrown_break = new.collision {
    flags = { own_attack = true, reaches_float_shoe = true, reaches_submerged = true, ["break"] = true },
}

-- A thrown attack that pierces and breaks (row 0x17: Django's Gun del
-- Sol, a flying shot variant, Guardian's strike).
collision.thrown_piercing_break = new.collision {
    flags = {
        own_attack = true,
        reaches_float_shoe = true,
        reaches_submerged = true,
        piercing = true,
        ["break"] = true,
    },
}

-- A pull of no side (row 0x1E: a gust; DustMan's DustBrk drawing things
-- in).
collision.pull = new.collision { flags = { no_guard_spark = true, pull = true, reaches_float_shoe = true } }

-- A breaking attack (row 0x06: a shot that breaks guards; the break
-- family's shots, a thrown obstacle; DustMan's junk, BigHook's flames,
-- AuraHed's head).
collision.breaking = new.collision { flags = { own_attack = true, reaches_float_shoe = true, ["break"] = true } }

-- Chip destruction (row 0x08: an attack that destroys the chip a navi holds; the chip destruction shot's).
collision.chip_destruction = new.collision {
    flags = { own_attack = true, reaches_float_shoe = true, chip_destruction = true },
}

-- A pushing attack (row 0x12: AirShot's shot, a tornado, WindRack's swing, AirSpin's spin).
collision.pushing = new.collision { flags = { own_attack = true, pushing = true, reaches_float_shoe = true } }

-- The VDoll curse's hits (row 0x19: a thrown attack that pierces; JudgeMan's
-- lash and GrabBnsh's hit too).
collision.curse = new.collision {
    flags = { own_attack = true, reaches_float_shoe = true, reaches_submerged = true, piercing = true },
}

-- An attack of row 0x25 (the wide shot's variant nothing fires).
collision.attack_480 = new.collision { flags = { own_attack = true, dark = true, reaches_float_shoe = true } }

-- An attack of row 0x47 (a projectile variant nothing names yet).
collision.attack_a0 = new.collision { flags = { own_attack = true, reaches_float_shoe = true, wind = true } }

-- A neutral body, while dimmed too (row 0x0E: a VDoll that landed, AirSpin's
-- top, a rock, a boulder, Guardian's statue, an encased obstacle's bubble).
collision.neutral_body = new.collision {
    flags = { neutral = true, hits_while_dimmed = true, reaches_float_shoe = true, ["break"] = true },
}

-- A probe (row 0x3D): what finds the first thing its target type reaches
-- without hurting it (the bullet, the corn, H-Burst's shot).
collision.probe = new.collision { flags = { reaches_float_shoe = true } }

-- Nothing (row 0x00: a target that reaches nothing; Discord's notes, which
-- confuse without learning they hit).
collision.nothing = new.collision { flags = {} }

-- Another body of its side, while dimmed too (row 0x13: the obstacles a
-- chip sets down: the instruments, AirRaid's plane, Sensor's turret, Wind's fan,
-- the Anubis statue).
collision.own_body = new.collision {
    flags = { own_other_body = true, hits_while_dimmed = true, reaches_float_shoe = true },
}

-- A breaking attack with the flag 0x400, whose test no routine was found
-- for (row 0x4A: a drill's second).
collision.second_drill = new.collision {
    flags = { own_attack = true, dark = true, reaches_float_shoe = true, ["break"] = true },
}

-- An attack that breaks guards (row 0x32: the instruments' notes).
collision.guard_breaking = new.collision {
    flags = { own_attack = true, no_guard_spark = true, breaks_guard = true, reaches_float_shoe = true },
}

-- A drain: an attack of its side that pierces invisibility and flashing
-- (row 0x2C: GunDelSol's hits under the sun beam).
collision.drain = new.collision {
    flags = {
        own_attack = true,
        no_guard_spark = true,
        reaches_float_shoe = true,
        reaches_submerged = true,
        piercing = true,
    },
}

-- A drain that also breaks (row 0x30: SunMoon's moonlight).
collision.breaking_drain = new.collision {
    flags = {
        own_attack = true,
        no_guard_spark = true,
        reaches_float_shoe = true,
        reaches_submerged = true,
        piercing = true,
        ["break"] = true,
    },
}

-- The rest of the original's rows (gen-content).
-- Row 0x03.
collision.collision_03 = new.collision {
    flags = { enemy_attack = true, enemy_object = true, enemy_other_body = true, neutral = true, drain = true },
}
-- Row 0x09.
collision.collision_09 = new.collision { flags = { own_attack = true, drain = true, reaches_float_shoe = true } }
-- Row 0x11.
collision.collision_11 = new.collision {
    flags = { own_attack = true, sword = true, dark = true, reaches_float_shoe = true },
}
-- Row 0x1A.
collision.collision_1a = new.collision {
    flags = {
        own_attack = true,
        reaches_float_shoe = true,
        chip_destruction = true,
        reaches_submerged = true,
        piercing = true,
        ["break"] = true,
    },
}
-- Row 0x1B.
collision.collision_1b = new.collision {
    flags = { own_attack = true, no_guard_spark = true, reaches_float_shoe = true, wind = true },
}
-- Row 0x1D.
collision.collision_1d = new.collision {
    flags = {
        own_attack = true,
        reaches_float_shoe = true,
        chip_destruction = true,
        reaches_submerged = true,
        piercing = true,
    },
}
-- Row 0x1F.
collision.collision_1f = new.collision {
    flags = { own_attack = true, reaches_set_objects = true, reaches_float_shoe = true, ["break"] = true },
}
-- Row 0x20.
collision.collision_20 = new.collision {
    flags = { own_attack = true, pushing = true, reaches_float_shoe = true, reaches_submerged = true },
}
-- Row 0x21.
collision.collision_21 = new.collision {
    flags = {
        own_attack = true,
        reaches_set_objects = true,
        reaches_float_shoe = true,
        reaches_submerged = true,
        ["break"] = true,
    },
}
-- Row 0x22.
collision.collision_22 = new.collision {
    flags = {
        own_attack = true,
        enemy_attack = true,
        reaches_set_objects = true,
        ground_only = true,
        reaches_float_shoe = true,
        reaches_submerged = true,
        piercing = true,
        ["break"] = true,
    },
}
-- Row 0x23.
collision.collision_23 = new.collision { flags = { blocker = true } }
-- Row 0x24.
collision.collision_24 = new.collision {
    flags = { own_attack = true, pushing = true, dark = true, reaches_float_shoe = true, reaches_submerged = true },
}
-- Row 0x26.
collision.collision_26 = new.collision {
    flags = {
        own_attack = true,
        enemy_attack = true,
        reaches_set_objects = true,
        reaches_float_shoe = true,
        reaches_submerged = true,
    },
}
-- Row 0x27.
collision.collision_27 = new.collision {
    flags = {
        own_attack = true,
        enemy_attack = true,
        reaches_set_objects = true,
        ground_only = true,
        reaches_float_shoe = true,
        ["break"] = true,
    },
}
-- Row 0x28.
collision.collision_28 = new.collision {
    flags = { own_attack = true, sword = true, reaches_float_shoe = true, piercing = true, ["break"] = true },
}
-- Row 0x29.
collision.collision_29 = new.collision {
    flags = { own_other_body = true, hits_while_dimmed = true, reaches_float_shoe = true, ["break"] = true },
}
-- Row 0x2D.
collision.collision_2d = new.collision {
    flags = {
        own_attack = true,
        no_guard_spark = true,
        reaches_float_shoe = true,
        reaches_submerged = true,
        ["break"] = true,
    },
}
-- Row 0x2E.
collision.collision_2e = new.collision {
    flags = { own_attack = true, no_guard_spark = true, reaches_float_shoe = true, piercing = true, ["break"] = true },
}
-- Row 0x2F.
collision.collision_2f = new.collision {
    flags = { own_attack = true, no_guard_spark = true, reaches_float_shoe = true, reaches_submerged = true },
}
-- Row 0x31.
collision.collision_31 = new.collision {
    flags = {
        own_attack = true,
        no_guard_spark = true,
        breaks_guard = true,
        reaches_float_shoe = true,
        piercing = true,
    },
}
-- Row 0x35.
collision.collision_35 = new.collision {
    flags = { own_body = true, own_navi = true, hits_while_dimmed = true, reaches_float_shoe = true, ["break"] = true },
}
-- Row 0x36.
collision.collision_36 = new.collision {
    flags = { own_attack = true, no_guard_spark = true, reaches_float_shoe = true, ["break"] = true },
}
-- Row 0x37.
collision.collision_37 = new.collision {
    flags = {
        own_other_body = true,
        hits_while_dimmed = true,
        reaches_float_shoe = true,
        reaches_submerged = true,
        ["break"] = true,
    },
}
-- Row 0x38.
collision.collision_38 = new.collision {
    flags = { own_body = true, enemy_body = true, own_other_body = true, enemy_other_body = true, neutral = true },
}
-- Row 0x39.
collision.collision_39 = new.collision {
    flags = {
        own_body = true,
        own_navi = true,
        floating = true,
        hits_while_dimmed = true,
        reaches_float_shoe = true,
        ["break"] = true,
    },
}
-- Row 0x3A.
collision.collision_3a = new.collision {
    flags = {
        own_body = true,
        own_navi = true,
        hits_while_dimmed = true,
        reaches_float_shoe = true,
        reaches_submerged = true,
        ["break"] = true,
    },
}
-- Row 0x3B.
collision.collision_3b = new.collision {
    flags = { own_object = true, hits_while_dimmed = true, reaches_float_shoe = true, ["break"] = true },
}
-- Row 0x3C.
collision.collision_3c = new.collision {
    flags = {
        own_attack = true,
        no_guard_spark = true,
        reaches_float_shoe = true,
        reaches_submerged = true,
        ["break"] = true,
    },
}
-- Row 0x3E.
collision.collision_3e = new.collision {
    flags = { own_other_body = true, floating = true, hits_while_dimmed = true, reaches_float_shoe = true },
}
-- Row 0x3F.
collision.collision_3f = new.collision {
    flags = {
        own_body = true,
        own_navi = true,
        floating = true,
        hits_while_dimmed = true,
        reaches_float_shoe = true,
        reaches_submerged = true,
        ["break"] = true,
    },
}
-- Row 0x40.
collision.collision_40 = new.collision {
    flags = { own_object = true, hits_while_dimmed = true, sword = true, reaches_float_shoe = true },
}
-- Row 0x41.
collision.collision_41 = new.collision { flags = { enemy_body = true } }
-- Row 0x42.
collision.collision_42 = new.collision {
    flags = { own_attack = true, sword = true, reaches_float_shoe = true, chip_destruction = true },
}
-- Row 0x43.
collision.collision_43 = new.collision { flags = { reaches_set_objects = true, reaches_float_shoe = true } }
-- Row 0x44.
collision.collision_44 = new.collision {
    flags = { own_object = true, reaches_set_objects = true, hits_while_dimmed = true, reaches_float_shoe = true },
}
-- Row 0x45.
collision.collision_45 = new.collision {
    flags = { own_attack = true, sword = true, reaches_float_shoe = true, reaches_submerged = true, ["break"] = true },
}
-- Row 0x46.
collision.collision_46 = new.collision {
    flags = {
        own_attack = true,
        hits_while_dimmed = true,
        no_guard_spark = true,
        reaches_float_shoe = true,
        wind = true,
    },
}
-- Row 0x48.
collision.hitbox = new.collision {
    flags = { own_attack = true, enemy_attack = true, reaches_set_objects = true, reaches_float_shoe = true },
}
-- Row 0x4B.
collision.collision_4b = new.collision {
    flags = { own_attack = true, pushing = true, dark = true, reaches_float_shoe = true, reaches_submerged = true },
}
-- Row 0x4C.
collision.collision_4c = new.collision {
    flags = {
        own_other_body = true,
        hits_while_dimmed = true,
        no_guard_spark = true,
        reaches_float_shoe = true,
        ["break"] = true,
    },
}
-- Row 0x4D.
collision.collision_4d = new.collision {
    flags = { enemy_attack = true, enemy_object = true, enemy_body = true, enemy_other_body = true, pull = true },
}
-- Row 0x50.
collision.collision_50 = new.collision {
    flags = { own_body = true, own_navi = true, hits_while_dimmed = true, sword = true, reaches_float_shoe = true },
}
-- Row 0x51.
collision.collision_51 = new.collision {
    flags = {
        own_body = true,
        own_navi = true,
        hits_while_dimmed = true,
        reaches_float_shoe = true,
        chip_destruction = true,
        ["break"] = true,
    },
}
-- Row 0x53.
collision.collision_53 = new.collision {
    flags = {
        own_body = true,
        own_navi = true,
        hits_while_dimmed = true,
        sword = true,
        reaches_float_shoe = true,
        ["break"] = true,
    },
}
-- Row 0x54.
collision.collision_54 = new.collision {
    flags = { own_attack = true, sword = true, reaches_float_shoe = true, chip_destruction = true, ["break"] = true },
}
-- Row 0x55.
collision.collision_55 = new.collision {
    flags = {
        own_body = true,
        own_navi = true,
        hits_while_dimmed = true,
        reaches_float_shoe = true,
        chip_destruction = true,
        reaches_submerged = true,
        ["break"] = true,
    },
}
-- Row 0x56.
collision.collision_56 = new.collision {
    flags = { own_attack = true, pushing = true, reaches_float_shoe = true, piercing = true },
}
-- Row 0x57.
collision.collision_57 = new.collision {
    flags = { own_attack = true, reaches_float_shoe = true, wind = true, chip_destruction = true, ["break"] = true },
}

return collision
