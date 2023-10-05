-----------------------------------
-- Monstrosity
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-----------------------------------
-- Enums
-----------------------------------

xi.monstrosity.species =
{
    RABBIT     =  1,
    MANDRAGORA = 18,
    LIZARD     = 43,
}

-----------------------------------
-- Helpers
-----------------------------------

xi.monstrosity.unlockStartingMONs = function(player, choice)
    local data =
    {
        monstrosityId = choice,
        species       = choice,
        levels        =
        {
            [xi.monstrosity.species.RABBIT]     = 1,
            [xi.monstrosity.species.MANDRAGORA] = 1,
            [xi.monstrosity.species.LIZARD]     = 1,
        }
    }

    player:setMonstrosity(data)
end

-----------------------------------
-- Odyssean Passage
-----------------------------------

xi.monstrosity.odysseanPassageOnTrigger = function(player, npc)
    -- TODO: Handle xi.settings.main.ENABLE_MONSTROSITY

    -- TODO: If passage in the overworld, do logic X
    local isMonstrosityUnlocked = player:hasKeyItem(xi.keyItem.RING_OF_SUPERNAL_DISJUNCTION)
    if isMonstrosityUnlocked then
        player:startEvent(883)
    end

    -- TODO: If passage in Feretory, do logic Y
    -- In Feretory: Event 5 (0, 0, 0, 0, 0, 0, 0, 0)
end

-----------------------------------
-- Feretory
-----------------------------------

xi.monstrosity.feretoryOnZoneIn = function(player, prevZone)
    -- TODO: Handle xi.settings.main.ENABLE_MONSTROSITY

    -- TODO: Rabbit, Mandy, and Lizard are all unlocked to begin with, but you
    --     : start as whatever matching item you traded

    local cs = -1

    player:setPos(-358.000, -3.400, -440.00, 63)

    return cs
end

xi.monstrosity.feretoryOnEventUpdate = function(player, csid, option, npc)
end

xi.monstrosity.feretoryOnEventFinish = function(player, csid, option, npc)
end

-----------------------------------
-- Aengus (Feretory NPC)
-----------------------------------
-- Event 13 (As Lizard: 0, 0, 2, 0, 2, 90, 0, 0)

-----------------------------------
-- Teyrnon (Feretory NPC)
-----------------------------------
-- Event 7 (As Lizard: 0, 0, 0, 0, 0, 0, 0, 0)

-----------------------------------
-- Maccus (Feretory NPC)
-----------------------------------
-- Event 9 (As Lizard: 285, 2, 2, 0, 0, 0, 0, 0)

-----------------------------------
-- Suibhne (Feretory NPC)
-----------------------------------
-- Event 11 (As Lizard: 1, 1, 0, 0, 0, 0, 0, 0)
