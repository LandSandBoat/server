-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl's Hound Warrior
-- Note: Pet for Xolotl
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 32)
end

entity.onMobRoam = function(mob)
    local xolotlID = mob:getID() - 1
    local xolotl = GetMobByID(xolotlID)

    if xolotl then
        if not xolotl:isSpawned() then
            DespawnMob(mob:getID())
        else
            mob:follow(xolotl, xi.followType.ROAM)
        end
    end
end

entity.onMobDespawn = function(mob)
    local xolotlID = mob:getID() - 1
    GetMobByID(xolotlID):setLocalVar("[XOLOTL]HoundCooldown", GetSystemTime() + math.random(30, 120))
end

return entity
