-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Arvilauge
-- Type: Chocobo Stable Clerk
-- !pos -13.237 1.399 -93.206 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local walks  = xi.chocoboRaising.walks
    local params = walks.clerkReview(player:getCharVar(walks.lostChickVar), xi.chocoboRaising.raisingLocation[player:getZoneID()])
    params[1]    = math.floor(player:getCharSkillLevel(xi.skill.DIG) / 10)

    player:startEvent(846, params)
end

return entity
