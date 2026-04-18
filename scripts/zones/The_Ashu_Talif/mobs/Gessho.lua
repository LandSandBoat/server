-----------------------------------
-- Area: The Ashu Talif (The Black Coffin)
--  Mob: Gessho
-- TOAU-15 Mission Battle
-----------------------------------
local ID = zones[xi.zone.THE_ASHU_TALIF]
mixins = { require('scripts/mixins/helper_npc') }
-----------------------------------
---@type TMobEntity
local entity = {}

local pathNodes =
{
    { x =  2.643, y = -22.218, z = 25.106 },
    { x = -2.977, y = -22.000, z = 24.983 },
    { x = -9.154, y = -22.000, z = 18.131 },
    { x =  9.217, y = -22.000, z = 18.020 },
    { x =  8.746, y = -22.000, z =  7.519 },
    { x = -8.620, y = -22.058, z =  9.165 },
    { x = -7.054, y = -22.000, z = 24.549 },
    { x = -7.045, y = -26.687, z = 32.233 },
    { x = -7.019, y = -31.000, z = 41.725 },
    { x = -9.981, y = -31.164, z = 56.641 },
    { x = 10.220, y = -31.020, z = 56.987 },
    { x =  6.918, y = -31.000, z = 42.086 },
    { x =  6.889, y = -27.000, z = 32.705 },
    { x =  6.722, y = -22.000, z = 24.086 },
}

local function getTargetMobIds(mob)
    local targetMobs = {}
    for offset = 0, 4 do
        table.insert(targetMobs, ID.mob.ASHU_CREW_OFFSET + offset)
        table.insert(targetMobs, ID.mob.ASHU_CAPTAIN_OFFSET + offset)
    end

    return targetMobs
end

-- Find nodes that are at least 7 yalms away and within 30 yalms
local function findClosestNode(mob, target)
    local candidates = {}
    local mobPos     = mob:getPos()
    local targetPos  = target:getPos()

    for _, node in ipairs(pathNodes) do
        local distFromTarget = utils.distance(targetPos, node)
        if
            distFromTarget >= 7 and
            distFromTarget <= 30
        then
            local distFromMob = utils.distance(mobPos, node)
            table.insert(candidates, { node = node, distance = distFromMob })
        end
    end

    if #candidates == 0 then
        return nil
    end

    -- Sort by distance from mob, then pick randomly from the top 3 closest nodes
    table.sort(candidates, function(a, b)
        return a.distance < b.distance
    end)

    local topCount = math.min(3, #candidates)
    local chosen   = candidates[math.random(1, topCount)]

    return chosen.node
end

entity.onMobSpawn = function(mob)
    -- Setup Helper NPC config
    local helperConfig =
    {
        targetMobs = getTargetMobIds,
    }
    xi.mix.helperNpc.config(mob, helperConfig)

    mob:setBehavior(xi.behavior.NO_DESPAWN)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 50)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 1)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 100)

    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(true)
end

entity.onMobEngage = function(mob, target)
    if mob:getLocalVar('dialog') == 0 then
        mob:showText(mob, ID.text.BATTLE_HIGH_SEAS)
        mob:setLocalVar('dialog', 1)
    end

    mob:setLocalVar('vulcanInterrupt', 0)
    mob:setLocalVar('teleportTimer', 0)
end

entity.onMobFight = function(mob, target)
    -- Print near death warning
    if mob:getHPP() <= 33 and mob:getLocalVar('dialog') == 1 then
        mob:showText(mob, ID.text.TIME_IS_NEAR)
        mob:setLocalVar('dialog', 2)
    end

    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Handle warp in/out
    local teleStarted = mob:getLocalVar('teleStarted')
    if teleStarted == 1 then
        mob:setUntargetable(false)
        mob:useMobAbility(xi.mobSkill.WARP_IN_GESSHO, nil, 0)
        return
    end

    if teleStarted == 2 then
        mob:hideName(false)

        if mob:getLocalVar('vulcanInterrupt') == 1 then
            local instance = mob:getInstance()
            local captain  = GetMobByID(ID.mob.ASHU_CAPTAIN_OFFSET, instance)
            if captain then
                mob:useMobAbility(xi.mobSkill.HIDEN_SOKYAKU, captain, 0)
            end

        else
            mob:useMobAbility(xi.mobSkill.HANE_FUBUKI)
        end

        mob:setAutoAttackEnabled(true)
        mob:setMagicCastingEnabled(true)
        return
    end

    if
        target:checkDistance(mob) >= 7 or
        GetSystemTime() < mob:getLocalVar('teleportTimer')
    then
        return
    end

    local node = findClosestNode(mob, target)
    if node then
        mob:useMobAbility(xi.mobSkill.WARP_OUT_GESSHO, nil, 0)
    end
end

entity.onMobMobskillChoose = function(mob, target)
    local tpList =
    {
        xi.mobSkill.SHIKO_NO_MITATE,
        xi.mobSkill.HAPPOBARAI,
        xi.mobSkill.RINPYOTOSHA,
    }

    return utils.randomEntry(tpList)
end

entity.onMobWeaponSkill = function(mob, target, skill)
    -- Handle skill messaging
    local wsText =
    {
        [xi.mobSkill.HANE_FUBUKI    ] = ID.text.UNNATURAL_CURS,
        [xi.mobSkill.HIDEN_SOKYAKU  ] = ID.text.STING_OF_MY_BLADE,
        [xi.mobSkill.SHIKO_NO_MITATE] = ID.text.SWIFT_AS_LIGHTNING,
        [xi.mobSkill.HAPPOBARAI     ] = ID.text.HARNESS_THE_WHIRLWIND,
        [xi.mobSkill.RINPYOTOSHA    ] = ID.text.SWIFT_AS_LIGHTNING,
    }

    local skillId = skill:getID()
    local textID  = wsText[skillId]

    if textID then
        mob:showText(mob, textID)
    end

    -- Teleport Sequence: Tele out -> reposition -> Tele in -> Hiden Sokyaku (if interrupting Vulcan Shot) or Hane Fubuki
    switch (skillId) : caseof
    {
        [xi.mobSkill.WARP_OUT_GESSHO] = function()
            skill:setAnimationTime(0)
            mob:hideName(true)
            mob:setUntargetable(true)
            mob:setAutoAttackEnabled(false)
            mob:setMagicCastingEnabled(false)

            mob:setLocalVar('teleportTimer', GetSystemTime() + 25)
            mob:setLocalVar('teleStarted', 1)
        end,

        [xi.mobSkill.WARP_IN_GESSHO] = function()
            local node      = nil
            local interrupt = mob:getLocalVar('vulcanInterrupt')
            -- Vulcan Shot interrupt places Gessho near the captain. Normal teleports use path nodes.
            if interrupt == 1 then
                local instance = mob:getInstance()
                local captain  = GetMobByID(ID.mob.ASHU_CAPTAIN_OFFSET, instance)
                if captain then
                    node =
                    {
                        x = captain:getXPos() + math.random(-2, 2),
                        y = captain:getYPos(),
                        z = captain:getZPos() + math.random(-2, 2)
                    }
                end
            else
                local mobTarget = mob:getTarget()
                if mobTarget then
                    node = findClosestNode(mob, mobTarget)
                end
            end

            if node then
                mob:setPos(node.x, node.y, node.z, mob:getRotPos())
            end

            mob:setLocalVar('teleStarted', 2)
        end,

        [xi.mobSkill.HIDEN_SOKYAKU] = function()
            mob:setLocalVar('vulcanInterrupt', 0)
            mob:setLocalVar('teleStarted', 0)
        end,

        [xi.mobSkill.HANE_FUBUKI] = function()
            mob:setLocalVar('teleStarted', 0)
        end,
    }
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.DOTON_ICHI,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [2] = { xi.magic.spell.KATON_ICHI,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [3] = { xi.magic.spell.HYOTON_ICHI,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [4] = { xi.magic.spell.HUTON_ICHI,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [5] = { xi.magic.spell.RAITON_ICHI,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [6] = { xi.magic.spell.SUITON_ICHI,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [7] = { xi.magic.spell.DOKUMORI_ICHI, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,     0, 100 },
        [8] = { xi.magic.spell.UTSUSEMI_ICHI, mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.COPY_IMAGE, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:showText(mob, ID.text.SO_I_FALL)
    mob:setUntargetable(true)
end

return entity
