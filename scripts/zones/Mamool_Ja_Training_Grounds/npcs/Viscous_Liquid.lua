-----------------------------------
-- Area: Mamool Ja Training Grounds (Breaking Morale)
--  Mob: Viscous Liquid
-- Note: Turns the player into a mamool with a heavy negative HP effect.
-----------------------------------
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
local entity = {}

local lootTable =
{
    [17047813] = xi.items.FIGHTING_FISH_TANK,
    [17047814] = xi.items.GOBLIN_DIE,
    [17047815] = xi.items.PIECE_OF_ATTOHWA_GINSENG,
    [17047816] = xi.items.MAMOOL_JA_COLLAR,
    [17047817] = xi.items.DIVINATION_SPHERE,
    [17047818] = xi.items.TORN_EPISTLE,
    [17047819] = xi.items.GILT_GLASSES,
    [17047820] = xi.items.WILD_RABBIT_TAIL,
}

entity.onTrigger = function(player, npc)
    local flag = true

    for i = 1, #lootTable do
        local item = lootTable[i]

        if xi.assault.hasTempItem(player, item) then
            flag = false
        end
    end

    if flag then
        player:startEvent(103)
    end
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 103 and
        option == 1
    then
        player:addStatusEffect(xi.effect.COSTUME, 1602, 0, 900)
        player:messageSpecial(ID.text.PECULIAR_SENSATION)
    end
end

return entity
