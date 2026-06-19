-----------------------------------
-- Area: Lebros Cavern (Siegemaster Assassination)
-- MOB: Old Troll
-----------------------------------
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/weapon_break'),
}
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        chance = 100,
        hpp = math.random(25, 85)
    })
end

entity.onMobFight = function(mob, target)
    local instance = mob:getInstance()
    local mobs = instance:getMobs()
    local mobID = mob:getID()
    local oldTrollOffset = 17035327
    local oldTrollNumber = mobID - oldTrollOffset
    local borgerlur = instance:getProgress()

    if oldTrollNumber == borgerlur then -- if Borgerlur is fighting all engaged trolls will share target
        for _, troll in pairs(mobs) do
            if troll:isEngaged() then
                troll:updateEnmity(target)
            end
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    local instance = mob:getInstance()
    local chars = instance:getChars()
    local mobID = mob:getID()
    local oldTrollOffset = 17035327
    local oldTrollNumber = mobID - oldTrollOffset
    local borgerlur = instance:getProgress()

    if isKiller then
        if oldTrollNumber == borgerlur then
            for _, char in pairs(chars) do
                char:messageSpecial(ID.text.BORGERLUR_LOST)
            end

            mob:timer(3 * 1000, instance:complete())
        else
            mob:timer(3.75 * 60 * 1000, function(mobArg)
                if instance then
                    SpawnMob(mobArg:getID(), instance)
                    -- Wikis say the Old Trolls will keep enmity they had on death when they respawn
                    -- I did not see this behavior on current retail, need more investigation and discussion
                end
            end)
        end
    end
end

entity.onMobDespawn = function(mob)
end

return entity
