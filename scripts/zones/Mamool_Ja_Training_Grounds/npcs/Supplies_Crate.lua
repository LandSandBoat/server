
----------------------------------------
-- Area: Mamool Ja Training Grounds (Breaking Morale)
--  Npc: Supplies Crate
----------------------------------------
require("scripts/globals/assault")
----------------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
local entity = {}

local lootTable =
{
    [17047813] = xi.items.FIGHTING_FISH_TANK,
    [17047814] = xi.items.WILD_RABBIT_TAIL,
    [17047815] = xi.items.DIVINATION_SPHERE,
    [17047816] = xi.items.MAMOOL_JA_COLLAR,
    [17047817] = xi.items.PIECE_OF_ATTOHWA_GINSENG,
    [17047818] = xi.items.TORN_EPISTLE,
    [17047819] = xi.items.GILT_GLASSES,
    [17047820] = xi.items.GOBLIN_DIE,
}

entity.onSpawn = function(npc)
    npc:setStatus(xi.status.NORMAL)
end

entity.onTrigger = function(player, npc)
    local item = lootTable[npc:getID()]

    if
        npc:getLocalVar("isAvailable") == 0 and
        not xi.assault.hasTempItem(player, item)
    then
        npc:entityAnimationPacket("open")
        npcUtil.giveTempItem(player, item)
        npc:setLocalVar("isAvailable", 1)
    end

    -- Animate opening

    -- Reset var before disappearing
    npc:timer(7500, function(npcArg)
        npcArg:setLocalVar("isAvailable", 0)
    end)
end

return entity
