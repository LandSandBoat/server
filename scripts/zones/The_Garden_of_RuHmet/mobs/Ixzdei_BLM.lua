-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'zdei (Black Mage)
-- Note: CoP Mission 8-3
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/magic")
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.LEDGE_AGGRO, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 10)
    mob:setMobMod(xi.mobMod.NO_REST, 1)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MANAFONT, hpp = math.random(50, 80) },
        },
    })
    mob:setAnimationSub(0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(false)
    mob:setLocalVar("runbackChance", math.random(1, 4))
    mob:setLocalVar("healpercent", math.random(15, 25))
end

entity.onMobEngaged = function(mob, target)
    mob:setAnimationSub(1)
    mob:setLocalVar("changeTime", os.time() + 15)
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
    mob:setLocalVar("changeTime", 0)
    mob:setSpellList(5074) -- Only casts tier 1 nukes as first spell
    -- Zdeis wait 3 seconds to cast their first spell
    mob:timer(3000, function(mobArg)
        mobArg:setMagicCastingEnabled(true)
    end)
    mob:timer(4000, function(mobArg)
        mobArg:setSpellList(467)
    end)
end

entity.onMobFight = function(mob, target)
    local changeTime = mob:getLocalVar("changeTime")

    if mob:canUseAbilities() and os.time() > changeTime and mob:getBattleTime() > 10 then
        for i = 1, 3 do
            changeTime = mob:getLocalVar("changeTime")
            if mob:getAnimationSub() == i and os.time() > changeTime then
                local newSub = math.random(1, 3)
                while newSub == i do
                    newSub = math.random(1, 3)
                end
                mob:setAnimationSub(newSub)
                mob:setLocalVar("changeTime", os.time() + math.random(15, 45))
            end
        end
    end

    local hpp = mob:getHPP()
    local healpercent = mob:getLocalVar("healpercent")
    local runbackChance = mob:getLocalVar("runbackChance")
    local heal = mob:getLocalVar("heal")
    local zdeiOne = GetMobByID(ID.mob.IXZDEI_BASE + 2)
    local zdeiTwo = GetMobByID(ID.mob.IXZDEI_BASE + 3)
    if
        hpp < healpercent and
        heal == 0 and
        runbackChance == 1
    then -- if zdei is under the hp threshold and hasn't run to it's spawnpoint yet then
        local mobID = mob:getID()
        switch (mobID): caseof
        {
            [ID.mob.IXZDEI_BASE + 2] = function()
                local spawnPos = zdeiOne:getSpawnPos()
                mob:setMagicCastingEnabled(false)
                mob:pathTo(spawnPos.x, spawnPos.y, spawnPos.z)
                if
                    mob:checkDistance(spawnPos.x, spawnPos.y, spawnPos.z) < 2 and
                    zdeiOne:getLocalVar("healed") == 0
                then
                    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
                    mob:setLocalVar("healed", 1)
                    mob:setLocalVar("heal", 1)
                    mob:timer(8000, function(mobArg)
                        if mob:isAlive() then
                            mob:useMobAbility(626)
                        end
                    end)
                end
            end,

            [ID.mob.IXZDEI_BASE + 3] = function()
                local spawnPos = zdeiTwo:getSpawnPos()
                mob:setMagicCastingEnabled(false)
                mob:pathTo(spawnPos.x, spawnPos.y, spawnPos.z)
                if
                    mob:checkDistance(spawnPos.x, spawnPos.y, spawnPos.z) < 2 and
                    zdeiTwo:getLocalVar("healed") == 0
                then
                    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
                    mob:setLocalVar("healed", 1)
                    mob:setLocalVar("heal", 1)
                    mob:timer(8000, function(mobArg)
                        if mob:isAlive() then
                            mob:setLocalVar("twohourTP", mob:getTP())
                            mob:useMobAbility(626)
                        end
                    end)
                end
            end,
        }
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 626 then
        mob:setHP(6500)
        mob:setTP(mob:getLocalVar("twohourTP"))
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        mob:setMagicCastingEnabled(true)
    end
end

entity.onMobDisengage = function(mob)
    mob:setAnimationSub(0)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
