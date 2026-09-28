-----------------------------------
-- Area: Bastok Mines
--  NPC: Gonija
-- Type: Chocobo Stable Clerk
-- !pos 27.711 0.874 -104.910 234
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local walks  = xi.chocoboRaising.walks
    local params = walks.clerkReview(player:getCharVar(walks.lostChickVar), xi.chocoboRaising.raisingLocation[player:getZoneID()])
    params[1]    = math.floor(player:getCharSkillLevel(xi.skill.DIG) / 10)

    player:startEvent(534, params)
end

return entity
