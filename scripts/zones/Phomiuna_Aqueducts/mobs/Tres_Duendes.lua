-----------------------------------
-- Area: Phomiuna_Aqueducts
--   NM: Tres Duendes
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSpawn = function(mob)
    local petId = ID.mob.TRES_DUENDES + 1
    xi.mob.callPets(mob, petId, { inactiveTime = 1000 })
end

entity.onMobEngage = function(mob)
    mob:setLocalVar('nextFormShiftTime', GetSystemTime() + 60)
end

entity.onMobFight = function(mob, target)
    local nextFormShiftTime = mob:getLocalVar('nextFormShiftTime')
    local form = mob:getAnimationSub()

    if GetSystemTime() > nextFormShiftTime and mob:canUseAbilities() then
        mob:setLocalVar('nextFormShiftTime', GetSystemTime() + 60)

        local formConfigs =
        {
            vertical   = { bonus =  0,  delay = 4750, animSub = 15, tripleAtk = 100 }, -- 100% Triple Attack
            horizontal = { bonus = 22,  delay = 4600, animSub = 14, tripleAtk = 0   }, -- Slow delay, Strong mob weapon bonus (level * 1.5)
            normal     = { bonus =  0,  delay = 2400, animSub = 13, tripleAtk = 0   }, -- Normal bats
        }

        local selectedForm
        if form == 12 or form == 13 then
            selectedForm = math.random(1, 2) == 1 and formConfigs.vertical or formConfigs.horizontal
        else
            selectedForm = formConfigs.normal
        end

        -- Disable auto-attacks during form change animation
        mob:setAutoAttackEnabled(false)
        mob:timer(3000, function(mobArg)
            mobArg:setAutoAttackEnabled(true)
        end)

        mob:setMobMod(xi.mobMod.WEAPON_BONUS, selectedForm.bonus)
        mob:setDelay(selectedForm.delay)
        mob:setAnimationSub(selectedForm.animSub)
        mob:setMod(xi.mod.TRIPLE_ATTACK, selectedForm.tripleAtk)
    end
end

entity.onMobMobskillChoose = function(mob, target)
    local form = mob:getAnimationSub()
    local tpMoves =
    {
        xi.mobSkill.SONIC_BOOM_1,
        xi.mobSkill.JET_STREAM_1,
        xi.mobSkill.SLIPSTREAM_1,
        xi.mobSkill.TURBULENCE_1,
    }

    if form == 14 then -- Horizontal form
        table.insert(tpMoves, xi.mobSkill.TRAIN_FALL)
    elseif form == 15 then -- Vertical form
        table.insert(tpMoves, xi.mobSkill.KNIFE_EDGE_CIRCLE)
    end

    return tpMoves[math.random(1, #tpMoves)]
end

entity.onMobDisengage = function(mob)
    -- Reset to normal form with normal mode stats
    mob:setAnimationSub(13)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 0)
    mob:setDelay(2400)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 0)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
