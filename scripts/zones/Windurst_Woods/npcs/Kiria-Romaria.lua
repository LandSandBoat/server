-----------------------------------
-- Area: Windurst Woods
--  NPC: Kiria-Romaria
-- Type: Chocobo Stable Clerk
-- !pos 127.687 -5.250 -121.720 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local walks  = xi.chocoboRaising.walks
    local params = walks.clerkReview(player:getCharVar(walks.lostChickVar), xi.chocoboRaising.raisingLocation[player:getZoneID()])
    params[1]    = math.floor(player:getCharSkillLevel(xi.skill.DIG) / 10)

    player:startEvent(761, params)
end

return entity
