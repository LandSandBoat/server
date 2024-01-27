-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Granite Door
-- Notes: Door blocked by Temple Guardian
-- !pos -62 0 -99 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guardian = GetMobByID(ID.mob.TEMPLE_GUARDIAN)

    if npc:getAnimation() == xi.anim.CLOSE_DOOR then
        player:messageSpecial(ID.text.PROTECTED_BY_UNKNOWN_FORCE)
    end

    if guardian ~= nil and guardian:getHP() > 0 and guardian:getTarget() == nil then
        guardian:updateClaim(player)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
