-----------------------------------
-- Area: Bhaflau Remnants
--  MOB: Mad Bomber
--  Self-Destructs after about 75 seconds
--  Spawns Rampart if it dies before self-destruct
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(0)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('shifttime', 15)
end

entity.onMobFight = function(mob, target)
    local size = mob:getAnimationSub()
    local shifttime = mob:getLocalVar('shifttime')

    if mob:getBattleTime() > shifttime then
        if size == 3 then
            mob:addImmunity(xi.immunity.LIGHT_SLEEP)
            mob:addImmunity(xi.immunity.DARK_SLEEP)
            mob:addImmunity(xi.immunity.STUN)
            mob:addImmunity(xi.immunity.TERROR)
            mob:useMobAbility(597)
            mob:setLocalVar('timeUp', 1)
        else
            mob:setLocalVar('shifttime', shifttime + 20)
            mob:setAnimationSub(size + 1)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance and mob:getLocalVar('timeUp') == 0 then
            local dormant = GetNPCByID(ID.npc.DORMANT_RAMPART[1], instance)

            if dormant then
                dormant:setStatus(xi.status.NORMAL)
                dormant:setUntargetable(false)
            end
        end
    end
end

return entity
