--!strict
-- The Cross special's chips (`sub_802D5A8`, the chip gate battle's
-- berserk controller): a row by the hundreds of the navi's base max HP
-- (the first up to 199, the last from 1000), and a chip of it at random.
-- LifeSrd, in the last two rows, strikes with VarSwrd's damage
-- (`damage_of`).

local air_hockey = require("../chips/air_hockey").air_hockey
local aqua_sword = require("../chips/aqua_sword").aqua_sword
local bamboo_sword = require("../chips/bamboo_sword").bamboo_sword
local cannon_chips = require("../chips/cannon")
local dolthdr_chips = require("../chips/doll_thunder")
local elec_sword = require("../chips/elec_sword").elec_sword
local energbom_chips = require("../chips/energy_bomb")
local firebrn_chips = require("../chips/fire_burner")
local fire_sword = require("../chips/fire_sword").fire_sword
local gundels_chips = require("../chips/gun_del_sol")
local life_sword = require("../chips/life_sword").life_sword
local long_sword = require("../chips/long_sword").long_sword
local mini_bomb = require("../chips/mini_bomb").mini_bomb
local moon_blade = require("../chips/moon_blade").moon_blade
local rlnglog_chips = require("../chips/rolling_log")
local tankcan_chips = require("../chips/tank_cannon")
local tornado_chips = require("../chips/tornado")
local trnarrw_chips = require("../chips/train_arrow")
local variable_sword = require("../chips/variable_sword").variable_sword
local vulcan_chips = require("../chips/vulcan")
local wide_sword = require("../chips/wide_sword").wide_sword

local CROSS_SPECIAL = schema.record_type("cross_special")

-- (rules/beast's data, which its Cross special reads: a record of
-- type "cross_special", not a rule section the engine reads.)
return new.record(CROSS_SPECIAL, {
    rows = {
        { cannon_chips.cannon, mini_bomb, wide_sword },
        -- EnergBom.
        { cannon_chips.cannon, energbom_chips.energy_bomb, wide_sword },
        -- MegEnBom.
        { cannon_chips.high_cannon, energbom_chips.mega_energy_bomb, long_sword },
        { tankcan_chips.tank_cannon_1, firebrn_chips.fire_burner_2, fire_sword },
        { cannon_chips.mega_cannon, trnarrw_chips.train_arrow_2, aqua_sword },
        { tankcan_chips.tank_cannon_2, dolthdr_chips.doll_thunder_2, elec_sword },
        -- GunDelS2.
        { gundels_chips.gun_del_sol_2, rlnglog_chips.rolling_log_2, bamboo_sword },
        { tankcan_chips.tank_cannon_3, tornado_chips.tornado, moon_blade },
        { tankcan_chips.tank_cannon_3, air_hockey, { chip = life_sword, damage_of = variable_sword } },
        -- (SuprVulc.)
        {
            firebrn_chips.fire_burner_3,
            trnarrw_chips.train_arrow_3,
            dolthdr_chips.doll_thunder_3,
            rlnglog_chips.rolling_log_3,
            vulcan_chips.super_vulcan,
            { chip = life_sword, damage_of = variable_sword },
        },
    },
})
