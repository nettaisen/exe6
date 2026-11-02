--!strict
-- EXE6's backgrounds' definitions (the root's `backgrounds`): each background's music, the battle theme a round drawn
-- on it plays where the player picked none (docs/app.md §1, "The battle's music"). Each is the theme most of the
-- original's battles on it start (their settings' byte 2; a battle draws the background its settings state, or with
-- 0xFF its map's): the random encounters of the maps that draw it (`sub_80AA4C0`; the encounter lists `off_8020170`
-- and the story's three others, virus battles but for a conditional navi) and the battles their scripts start
-- (`battleSettingsList0`, by cutscene command 0x55 and text command FB 03). Lan's HP has no encounters and starts no
-- battle: link battles alone draw it, and theirs is a link battle's, the virus battles'. A comp or dungeon that ends
-- in a story navi's battle has the boss battles' (the user's pick: by count every one would be the virus battles',
-- its encounters outnumbering them).

return {
    asset.background("acdc-area", { music = asset.sound("virus-battle") }),
    asset.background("acdc-hp", { music = asset.sound("virus-battle") }),
    -- AquarumComp3's navi battle (record 0x43) ends its dungeon.
    asset.background("aquarium-comp", { music = asset.sound("boss-battle") }),
    asset.background("aquarium-hp", { music = asset.sound("virus-battle") }),
    asset.background("central-area", { music = asset.sound("virus-battle") }),
    asset.background("comp", { music = asset.sound("virus-battle") }),
    asset.background("comp-alt", { music = asset.sound("virus-battle") }),
    -- vs Cybeast, the user's pick: the two battles against a Cybeast (records 0x84 and 0x85) are on CopyBotComp. By
    -- count it would be the virus battles' (4 encounters).
    asset.background("copybot-comp", { music = asset.sound("final-battle") }),
    -- The crossover battle's, the user's pick: by count it would be the virus battles' (60, and 4 navis').
    asset.background("graveyard", { music = asset.sound("crossover-battle") }),
    asset.background("green-area", { music = asset.sound("virus-battle") }),
    asset.background("green-hp", { music = asset.sound("virus-battle") }),
    -- JdgTreeComp3's navi battle (record 0x51) ends its dungeon; PavilonComp2's (0x81) too.
    asset.background("judgetree-comp", { music = asset.sound("boss-battle") }),
    asset.background("lans-hp", { music = asset.sound("virus-battle") }),
    -- MrWeathrCmp3's navi battle (record 0x70) ends its dungeon; PavilonComp3's (0x82) too.
    asset.background("mr-weather-comp", { music = asset.sound("boss-battle") }),
    -- MrWeathrCmp in its storm: the same comp's.
    asset.background("mr-weather-comp-storm", { music = asset.sound("boss-battle") }),
    -- RobCtrlComp2's navi battle (record 0x41) ends its dungeon; PavilonComp4's (0x83) too.
    asset.background("robot-control-comp", { music = asset.sound("boss-battle") }),
    asset.background("seaside-area", { music = asset.sound("virus-battle") }),
    asset.background("sky-area", { music = asset.sound("virus-battle") }),
    asset.background("sky-hp", { music = asset.sound("virus-battle") }),
    -- Underground2's four navi battles (records 0x7A, 0x7B, 0x8C and 0x8D).
    asset.background("underground", { music = asset.sound("boss-battle") }),
    asset.background("undernet", { music = asset.sound("virus-battle") }),
}
