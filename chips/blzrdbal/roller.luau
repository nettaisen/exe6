--!strict
-- The snowball's roller (the original's attack object #0xB7, `sub_80DC260`):
-- the shared roller (@exelib/blzrdbal/roller), EXE6's kind: what it is and
-- reaches (rows 0x58 and 0x49), every attack, object and body of either
-- side; hit modifier 0, no spark.

local common = require("@exelib/blzrdbal/roller")

local roller = {}

roller.kind = common.make_kind {
    id = "blzrdbal/roller",
    self_type = new.collision {
        flags = {
            own_attack = true,
            enemy_attack = true,
            reaches_set_objects = true,
            no_guard_spark = true,
            reaches_float_shoe = true,
        },
        row_offset = 0x2C0,
    },
    target = new.collision {
        flags = {
            own_object = true,
            enemy_object = true,
            own_body = true,
            enemy_body = true,
            own_other_body = true,
            enemy_other_body = true,
            neutral = true,
        },
        row_offset = 0x248,
    },
}

return roller
