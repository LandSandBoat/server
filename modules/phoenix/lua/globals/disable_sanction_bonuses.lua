-----------------------------------
-- Phoenix Sanction Bonus Removal Module
--
-- Sanction is granted bare: the NPC never offers the regen, refresh or meal duration choice,
-- and the effect carries no experience point bonus.
-----------------------------------
require('modules/module_utils')

local m = Module:new('disable_sanction_bonuses')

m:addOverride('xi.besieged.onTrigger', function(player, npc, eventBase)
    local mercenaryRank = xi.besieged.getMercenaryRank(player)

    if mercenaryRank == 0 then
        player:startEvent(eventBase + 1, npc)
        return
    end

    local maps = bit.bor(
        player:hasKeyItem(xi.keyItem.MAP_OF_MAMOOK) and 1 or 0,
        player:hasKeyItem(xi.keyItem.MAP_OF_HALVUNG) and 2 or 0,
        player:hasKeyItem(xi.keyItem.MAP_OF_ARRAPAGO_REEF) and 4 or 0)

    player:startEvent(eventBase, player:getCurrency('imperial_standing'), maps + xi.besieged.cipherValue(), mercenaryRank, 0, 0, 0, 0, 0)
end)

-- Prevent potential workarounds to access the sanction bonuses by overriding the option
m:addOverride('xi.besieged.onEventFinish', function(player, csid, option, npc)
    if
        option == 16 or
        option == 32 or
        option == 48
    then
        option = 0
    end

    super(player, csid, option, npc)
end)

m:addOverride('xi.experiencePoints.getSanctionBonus', function(member, regionId)
    return 0
end)
