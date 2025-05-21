-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'zdei (Black Mage)
-- Note: CoP Mission 8-3
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

local chargeOptic = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)

    if mob:getLocalVar('opticInduration') ~= 1 then
        mob:timer(5000, function(mobArg)
            mobArg:useMobAbility(1464)
        end)
    elseif mob:getLocalVar('opticInduration') == 1 then
        mob:useMobAbility(1465)
        mob:setLocalVar('opticInduration', 0)
        mob:setAutoAttackEnabled(true)
        mob:setMobAbilityEnabled(true)
    end
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MANAFONT, hpp = math.random(50, 80) },
        },
    })
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setAnimationSub(0)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setLocalVar('healpercent', math.random(15, 25))
end

entity.onMobEngage = function(mob, target)
    local mobId = mob:getID()
    -- each pot steps off the pedastal after casting initial spell and engaging target
    switch (mobId): caseof
    {
        [ID.mob.IXZDEI_BASE + 2] = function()
            mob:pathTo(422.261, 0.000, 412.931)
        end,

        [ID.mob.IXZDEI_BASE + 3] = function()
            mob:pathTo(417.937, 0.000, 413.019)
        end,
    }
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setLocalVar('changeTime', 0)
    local firstCast = { 144, 149, 154, 164, 169 }
    mob:castSpell(firstCast[math.random(1, #firstCast)])
end

entity.onMobFight = function(mob, target)
    local randomTime = math.random(15, 45)
    local changeTime = mob:getLocalVar('changeTime')

    local isBusy = false
    local act = mob:getCurrentAction()
    if
        act == xi.act.MOBABILITY_START or
        act == xi.act.MOBABILITY_USING or
        act == xi.act.MOBABILITY_FINISH
    then
        isBusy = true
    end

    if
        mob:actionQueueEmpty() and
        not isBusy
    then -- dont change forms while charging Optic Induration
        if
            mob:getAnimationSub() == 0 and
            mob:getBattleTime() - changeTime > randomTime
        then
            mob:setAnimationSub(math.random(2, 3))
            mob:setLocalVar('changeTime', mob:getBattleTime())
        elseif
            mob:getAnimationSub() == 1 and
            mob:getBattleTime() - changeTime > randomTime
        then
            mob:setAnimationSub(math.random(2, 3))
            mob:setLocalVar('changeTime', mob:getBattleTime())
        elseif
            mob:getAnimationSub() == 2 and
            mob:getBattleTime() - changeTime > randomTime
        then
            local aniChance = math.random(0, 1)
            if aniChance == 0 then
                mob:setAnimationSub(0)
                mob:setLocalVar('changeTime', mob:getBattleTime())
            else
                mob:setAnimationSub(3)
                mob:setLocalVar('changeTime', mob:getBattleTime())
            end
        elseif
            mob:getAnimationSub() == 3 and
            mob:getBattleTime() - changeTime > randomTime
        then
            mob:setAnimationSub(math.random(0, 2))
            mob:setLocalVar('changeTime', mob:getBattleTime())
        end
    end

    local hpp = mob:getHPP()
    local healpercent = mob:getLocalVar('healpercent')
    local heal = mob:getLocalVar('heal')
    local zdeiOne = GetMobByID(ID.mob.IXZDEI_BASE + 2)
    local zdeiTwo = GetMobByID(ID.mob.IXZDEI_BASE + 3)
    if
        hpp < healpercent and
        heal == 0
    then -- if zdei is under the hp threshold and hasn't run to it's spawnpoint yet then
        local mobID = mob:getID()
        switch (mobID): caseof
        {
            [ID.mob.IXZDEI_BASE + 2] = function()
                if not zdeiOne then
                    return
                end

                local spawnPos = zdeiOne:getSpawnPos()
                mob:setMagicCastingEnabled(false)
                mob:pathTo(spawnPos.x, spawnPos.y, spawnPos.z)
                mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.STANDBACK))
                mob:timer(8000, function(mobArg)
                    if
                        mob:checkDistance(spawnPos.x, spawnPos.y, spawnPos.z) < 2 and
                        zdeiOne:getLocalVar('healed') == 0
                    then
                        mob:useMobAbility(626)
                        mob:setHP(6500)
                        mob:setLocalVar('healed', 1)
                        mob:setLocalVar('heal', 1)
                        mob:setMagicCastingEnabled(true)
                    end
                end)
            end,

            [ID.mob.IXZDEI_BASE + 3] = function()
                if not zdeiTwo then
                    return
                end

                local spawnPos = zdeiTwo:getSpawnPos()
                mob:setMagicCastingEnabled(false)
                mob:pathTo(spawnPos.x, spawnPos.y, spawnPos.z)
                mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.STANDBACK))
                mob:timer(8000, function(mobArg)
                    if
                        mob:checkDistance(spawnPos.x, spawnPos.y, spawnPos.z) < 2 and
                        zdeiTwo:getLocalVar('healed') == 0
                    then
                        mob:useMobAbility(626)
                        mob:setHP(6500)
                        mob:setLocalVar('healed', 1)
                        mob:setLocalVar('heal', 1)
                        mob:setMagicCastingEnabled(true)
                    end
                end)
            end,
        }
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()
    if skillID == 1464 then
        mob:setAnimationSub(0)
        local opticCounter = mob:getLocalVar('opticCounter')

        opticCounter = opticCounter + 1
        mob:setLocalVar('opticCounter', opticCounter)

        if opticCounter > 2 then
            mob:setLocalVar('opticCounter', 0)
            mob:setLocalVar('opticInduration', 1)
            chargeOptic(mob)
        else
            chargeOptic(mob)
        end
    end
end

entity.onMobDisengage = function(mob)
    mob:setAnimationSub(0)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
