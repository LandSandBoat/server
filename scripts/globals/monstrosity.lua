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
        },
        instincts =
        {
            [20] = 0x1F, -- Unlock all first tier player race instincts
        }
    }

    player:setMonstrosity(data)
end

-----------------------------------
-- Odyssean Passage
-----------------------------------

xi.monstrosity.odysseanPassageOnTrade = function(player, npc, trade)
end

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

xi.monstrosity.odysseanPassageOnEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
    player:updateEvent(0, 0, 0, 0, 1, 0, 0, 0)
end

xi.monstrosity.odysseanPassageOnEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
    -- Option 1: Leave & Teleport to last city zone
    -- Option 529: Teleport to Al'Taieu
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

xi.monstrosity.aengusOnTrade = function(player, npc, trade)
end

xi.monstrosity.aengusOnTrigger = function(player, npc)
    -- Event 13 (As Lizard: 0, 0, 2, 0, 2, 90, 0, 0)
    player:startEvent(13, 0, 0, 2, 0, 2, 90, 0, 0)
end

xi.monstrosity.aengusOnEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
end

xi.monstrosity.aengusOnEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
    if csid == 13 and option == 1 then
        -- Selected: Enter Belligerency
    end
end

-----------------------------------
-- Teyrnon (Feretory NPC)
-----------------------------------

xi.monstrosity.teyrnonOnTrade = function(player, npc, trade)
end

xi.monstrosity.teyrnonOnTrigger = function(player, npc)
    player:startEvent(7, 0, 0, 0, 0, 0, 0, 0, 0)
end

xi.monstrosity.teyrnonOnEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
    if csid == 7 and option == 0 then -- Monsters Menu
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    elseif csid == 7 and option == 1 then -- Instinct menu
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, 0)
    end
end

xi.monstrosity.teyrnonOnEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
    -- Support Menu:
    -- option    3: Dedication 1
    -- option  259: Dedication 2
    -- option  515: Regen
    -- option  771: Refresh
    -- option 1027: Protect
    -- option 1283: Shell
    -- option 1539: Haste
end

-----------------------------------
-- Maccus (Feretory NPC)
-----------------------------------

xi.monstrosity.maccusOnTrade = function(player, npc, trade)
end

xi.monstrosity.maccusOnTrigger = function(player, npc)
    player:startEvent(9, 285, 2, 2, 0, 0, 0, 0, 0)
end

xi.monstrosity.maccusOnEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
end

xi.monstrosity.maccusOnEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
end

-----------------------------------
-- Suibhne (Feretory NPC)
-----------------------------------

xi.monstrosity.suibhneOnTrade = function(player, npc, trade)
end

xi.monstrosity.suibhneOnTrigger = function(player, npc)
    player:startEvent(11, 1, 1, 0, 0, 0, 0, 0, 0)
end

xi.monstrosity.suibhneOnEventUpdate = function(player, csid, option, npc)
    print('update', csid, option)
end

xi.monstrosity.suibhneOnEventFinish = function(player, csid, option, npc)
    print('finish', csid, option)
    -- Answers:
    -- 1) 4. Teyrnon
    -- 2) 3. Suibhne
    -- 3) 1. Aengus
    if csid == 11 and option == 2 then
        -- Quiz failed
    elseif csid == 11 and option == 6029313 then
        -- Quiz succeeded
        -- TODO: Unlock Bee (MON)
    end
end
