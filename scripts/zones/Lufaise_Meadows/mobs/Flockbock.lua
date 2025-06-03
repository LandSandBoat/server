-----------------------------------
-- Area: Lufaise Meadows
--   NM: Flockbock
-- https://www.bg-wiki.com/ffxi/Flockbock
-- TODO: NM has several possible spawn locations
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- Has enhanced double attack.
    -- TODO: Exact STP value needs to be researched further
    mob:setMod(xi.mod.DOUBLE_ATTACK, 50)
    mob:addMod(xi.mod.STORETP,       25)
end

entity.onMobSpawn = function(mob)
    local petribreath = 269

    -- Petribreath resets hate on use
    mob:addListener('WEAPONSKILL_USE', 'PETRIBREATH_HATE_RESET', function(mobArg, target, wsid, tp, action)
        if wsid == petribreath then
            mob:resetEnmity(target)
        end
    end)

    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 442)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1-2 hours
end

return entity
