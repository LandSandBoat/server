-----------------------------------
-- Area: Sacrarium
--   NM: Keremet
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local keremet = mob:getID()

    -- Send spawned skeleton "pets" to Keremet's target
    for i = keremet + 1, keremet + 12 do
        local m = GetMobByID(i)
        if m:getCurrentAction() == xi.act.ROAMING then
            m:updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local mobID = mob:getID()
    for i = mobID + 1, mobID + 12 do
        local add = GetMobByID(i)
        if add:isAlive() then
            add:setHP(0)
        end
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(1200, 1800)) -- 20 to 30 minutes
end

return entity
