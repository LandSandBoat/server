-----------------------------------
-- Area: Gusgen Mines
--   NM: Wounded Wurfel
-----------------------------------
local entity = {}

entity.onMobRoam = function(mob)
    local totd = VanadielTOTD()
    if totd ~= xi.time.NEW_DAY and totd ~= xi.time.MIDNIGHT then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 234)
    mob:setLocalVar('cooldown', os.time() + (144 * 13)) -- 13 vanadiel hours guarantees it will not spawn twice in the same night
end

return entity
