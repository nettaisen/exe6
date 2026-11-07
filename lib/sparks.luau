--!strict
-- Hit sparks: what shows where a hit lands (`collision:set_hit_effect`).

local chip_destruction_spark_sprite = asset.sprite("chip-destruction-spark")
local explosion_sprite = asset.sprite("explosion")
local hit_marker_sprite = asset.sprite("hit-marker")
local hit_sparks_sprite = asset.sprite("hit-sparks")
local hit_sprite = asset.sprite("hit")
local impact_sprite = asset.sprite("impact")
local pink_flash_sprite = asset.sprite("pink-flash")
local spark_0e_sprite = asset.sprite("spark-0e")

local sparks = {}

-- By primary element (null, fire, aqua, elec, wood, and the drain), the spark
-- `sub_801A146` gives an attack of that element (hit effects 0 to 5).
local BY_ELEMENT: { [string]: Spark } = {
    null = new.spark { sprite = hit_sparks_sprite, anim = 0, palette = 0, steps = 4 },
    fire = new.spark { sprite = hit_sparks_sprite, anim = 2, palette = 0, steps = 15 },
    aqua = new.spark { sprite = hit_sparks_sprite, anim = 3, palette = 0, steps = 11 },
    elec = new.spark { sprite = hit_sparks_sprite, anim = 4, palette = 0, steps = 12 },
    wood = new.spark { sprite = hit_sparks_sprite, anim = 5, palette = 0, steps = 13 },
    drain = new.spark { sprite = pink_flash_sprite, anim = 0, palette = 0, steps = 10 },
}

-- The element sparks by name (hit effects 1 to 4), for hits that name
-- theirs rather than take their element's.
sparks.fire, sparks.aqua, sparks.elec, sparks.wood = BY_ELEMENT.fire, BY_ELEMENT.aqua, BY_ELEMENT.elec, BY_ELEMENT.wood

-- The plain hit (spark 0) and the charged shot's (5), as named sparks.
sparks.plain = BY_ELEMENT.null
sparks.charged = BY_ELEMENT.drain

-- The element sparks by name (hit effects 1 to 3: a flame's, a bubble
-- star's, a thunder ball's).
sparks.fire = BY_ELEMENT.fire
sparks.aqua = BY_ELEMENT.aqua
sparks.elec = BY_ELEMENT.elec

-- A cannon's impact (spark 7: the cannons, AirShot).
sparks.impact = new.spark { sprite = impact_sprite, anim = 0, palette = 0, steps = 19 }

-- A breaking hit (spark 0x0A: the break family's shots, a thrown obstacle,
-- JustcOne's fist, a rock; GroundMan's drill and rocks, DustMan's junk,
-- BigHook's flames).
sparks.breaking = new.spark { sprite = hit_sparks_sprite, anim = 1, palette = 0, steps = 8 }

-- The chip destruction hit spark (spark 9: the chip destruction shot's).
sparks.chip_destruction = new.spark { sprite = chip_destruction_spark_sprite, anim = 0, palette = 0, steps = 15 }

-- A blast (spark 0x0B: GigaCan's shot).
sparks.blast = new.spark { sprite = explosion_sprite, anim = 0, palette = 0, steps = 22 }

-- A bat's impact (spark 0x0D: BatCan's shot).
sparks.bat = new.spark { sprite = hit_marker_sprite, anim = 1, palette = 0, steps = 18 }

-- The element sparks by name (hit effects 1 to 3), for hits that name
-- theirs rather than take their element's.
sparks.fire, sparks.aqua, sparks.elec = BY_ELEMENT.fire, BY_ELEMENT.aqua, BY_ELEMENT.elec

-- The wood spark (hit effect 4): the boomerang's, the lances'.
sparks.wood = BY_ELEMENT.wood

-- The erase beams' spark (hit effect 0x0C).
sparks.erase = new.spark { sprite = pink_flash_sprite, anim = 0, palette = 2, steps = 10 }

-- A heavy hit's (hit effect 6): Magnum's shot, the beasts' claws and bites,
-- the flying shot's arrows, VDoll's curse, JudgeMan's books.
sparks.heavy = new.spark { sprite = hit_sparks_sprite, anim = 8, palette = 0, steps = 4 }

-- `sub_801A146`: the spark of an attack of `element` (its primary
-- element, the low nibble).
function sparks.of_element(element: Element): Spark
    local p = element.primary
    local s = if p then BY_ELEMENT[p.name] else nil
    if not s then
        error(string.format("sub_801A146: element %s has no hit spark", tostring(element)))
    end
    return s
end

-- The rest of the original's sparks (gen-content).
-- Spark 0x08.
sparks.guard = new.spark { sprite = hit_sprite, anim = 0, palette = 0, steps = 9 }
-- Spark 0x0E.
sparks.uninstall = new.spark { sprite = spark_0e_sprite, anim = 0, palette = 0, steps = 22 }

return sparks
