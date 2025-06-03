-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Sharin-Garin
-- Type: Adventurer's Assistant
-- !pos 122.658 -1.315 33.001 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local mercRank = xi.besieged.getMercenaryRank(player)
    local hasPermit = player:hasKeyItem(xi.ki.RUNIC_PORTAL_USE_PERMIT) and 1 or 0
    local points = player:getCurrency('imperial_standing')
    local hasAstral = xi.besieged.getAstralCandescence()
    local cost = 200 -- 200 IS to get a permit
    local captain = mercRank == 11 and 1 or 0

    player:startEvent(140, 0, mercRank, hasPermit, points, hasAstral, cost, captain)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 140 and
        option == 1 and
        npcUtil.giveKeyItem(player, xi.ki.RUNIC_PORTAL_USE_PERMIT)
    then
        player:delCurrency('imperial_standing', 200)
    elseif csid == 140 and option == 2 then
        npcUtil.giveKeyItem(player, xi.ki.RUNIC_PORTAL_USE_PERMIT)
    end
end

return entity
