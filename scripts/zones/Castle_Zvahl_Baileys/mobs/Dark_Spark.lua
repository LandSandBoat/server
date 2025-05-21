-----------------------------------
-- Area: Castle Zvahl Baileys
--  Mob: Dark Spark
-- Involved in Quests: Borghertz's Hands (AF Hands, Many job)
-- !pos 63 -24 21 161
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        player:getCharVar('BorghertzSparkKilled') == 0 and
        player:hasKeyItem(xi.ki.OLD_GAUNTLETS) and
        not player:hasKeyItem(xi.ki.SHADOW_FLAMES) and
        player:getCharVar('BorghertzCS') >= 2
    then
        player:setCharVar('BorghertzSparkKilled', 1)
    end
end

return entity
