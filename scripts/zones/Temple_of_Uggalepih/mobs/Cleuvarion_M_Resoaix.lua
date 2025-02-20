-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Cleuvarion M Resoaix
-- Involved with San d'Oria quest "Knight Stalker"
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
    -- check for Rompaulion death
    if
        player:getCharVar('KnightStalker_Progress') == 4 and
        GetMobByID(mob:getID() + 1):isDead()
    then
        player:setCharVar('KnightStalker_Kill', 1)
    end
end

return entity
