-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl's Sacrifice
-- Note: Pet for Xolotl
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, 32)
end

entity.onMobDespawn = function(mob)
    local xolotlID = mob:getID() - 2
    GetMobByID(xolotlID):setLocalVar("[XOLOTL]SacrificeCooldown", GetSystemTime() + math.random(30, 120))
end

entity.onMobRoam = function(mob)
    local xolotlID = mob:getID() - 2
    local xolotl = GetMobByID(xolotlID)

    if xolotl then
        if not xolotl:isSpawned() then
            DespawnMob(mob:getID())
        else
            mob:follow(xolotl, xi.followType.ROAM)
        end
    end
end

return entity
