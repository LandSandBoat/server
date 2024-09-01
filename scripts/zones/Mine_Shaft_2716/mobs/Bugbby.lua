-----------------------------------
-- Area: Mine Shaft 2716
-- CoP Mission 5-3 (A Century of Hardship)
-- NM: Bugbby
-----------------------------------
local ID = zones[xi.zone.MINE_SHAFT_2716]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MIGHTY_STRIKES, cooldown = 300, hpp = math.random(85, 95) }, -- 5min cooldown
        },
    })
end

entity.onMobFight = function(mob, target)
    local activeMoblins = {} -- clear list prior to checking
    local hateReset = mob:getLocalVar('hateResetTimer')
    local timeBlock = mob:getBattleTime() / 60 -- every 60 seconds, a random moblin calls for bugbby to attack their target

    if hateReset == 0 then
        hateReset = 1
        mob:setLocalVar('hateResetTimer', hateReset)
    end

    if timeBlock >= hateReset then
        local battlefieldArea = mob:getBattlefield():getArea()
        local mobIdOffset     = (battlefieldArea - 1) * 5

        mob:setLocalVar('hateResetTimer', hateReset + 1)
        for moblinId = ID.mob.MOVAMUQ + mobIdOffset, ID.mob.MOVAMUQ + mobIdOffset + 3 do
            local moblinAlive = GetMobByID(moblinId)

            if moblinAlive and moblinAlive:isAlive() then -- make sure we're not adding dead moblins into the table
                table.insert(activeMoblins, moblinId)
            end
        end

        if #activeMoblins > 0 then
            local randMoblin = GetMobByID(activeMoblins[math.random(#activeMoblins)]) -- choose random moblin from activeMoblins
            mob:disengage()
            mob:resetEnmity(target)

            if randMoblin then
                local randMoblinTarget = randMoblin:getTarget()
                if randMoblinTarget then
                    mob:updateEnmity(randMoblinTarget) -- attack the chosen random moblin's target
                end
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
