-----------------------------------
-- Area: Yhoator Jungle
--  NPC: Beastmen's Banner
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.expeditionaryForce.onBannerTrigger(player, npc)
end

return entity
