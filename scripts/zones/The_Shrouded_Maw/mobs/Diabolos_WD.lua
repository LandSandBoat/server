-----------------------------------
-- Area: The Shrouded Maw
--  Mob: Diabolos (Waking Dreams)
-----------------------------------
local ID = zones[xi.zone.THE_SHROUDED_MAW]
-----------------------------------
---@type TMobEntity
local entity = {}

-- Draw-in positions for each battlefield area
local drawInPositions =
{
    {
        { x = -243.91, y = -32.00, z = 275.70 },
        { x = -236.04, y = -32.00, z = 275.80 },
        { x = -231.97, y = -32.00, z = 292.14 },
        { x = -232.14, y = -32.00, z = 287.47 },
        { x = -236.41, y = -32.00, z = 287.88 },
        { x = -247.52, y = -32.00, z = 288.17 },
        { x = -243.42, y = -32.00, z = 287.84 },
    },

    {
        { x = -0.16, y = 8.00, z = -4.09 },
        { x =  8.06, y = 8.00, z = -4.44 },
        { x =  8.11, y = 8.00, z =  7.76 },
        { x = -0.12, y = 8.00, z = 11.98 },
        { x = -7.96, y = 8.00, z = 12.00 },
        { x = -7.93, y = 8.00, z =  0.21 },
        { x = -0.35, y = 8.00, z =  3.95 },
        { x = -0.04, y = 8.00, z =  7.97 },
    },

    {
        { x = 276.14, y = 48.00, z = -284.11 },
        { x = 271.90, y = 48.00, z = -280.18 },
        { x = 272.32, y = 48.00, z = -272.38 },
        { x = 275.79, y = 48.00, z = -267.98 },
        { x = 283.60, y = 48.00, z = -268.03 },
        { x = 287.72, y = 48.00, z = -271.83 },
        { x = 287.67, y = 48.00, z = -279.64 },
        { x = 284.09, y = 48.00, z = -283.96 },
    },
}

-- Y-axis thresholds for draw-in per area
local drawInYThresholds = { -25, 13, 52 }

-- Tile drop animations for each area
local tileDropAnimations =
{
    { 'byc1', 'bya1', 'byb1' },
    { 'byc2', 'bya2', 'byb2' },
    { 'byc3', 'bya3', 'byb3' },
    { 'byc4', 'bya4', 'byb4' },
    { 'byc5', 'bya5', 'byb5' },
    { 'byc6', 'bya6', 'byb6' },
    { 'byc7', 'bya7', 'byb7' },
    { 'byc8', 'bya8', 'byb8' },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    -- Cache instance calculation once on spawn
    local inst = math.floor((mob:getID() - ID.mob.DIABOLOS_WD) / 7)
    mob:setLocalVar('instance', inst)
    mob:setLocalVar('nightmarePercent', math.randomInt(50, 75))
    mob:setLocalVar('ruinousOmenPercent', math.randomInt(29, 41))
    -- Capture: the first cast comes 9 to 16 seconds after engage. The mod rolls 0 to 16.
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 17)
    -- The tile-drop swing carries over to the next spawn.
    mob:setDelay(240)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    -- Pets never draw his enmity. Their masters do instead.
    mob:setMobMod(xi.mobMod.IGNORE_PETS, 1)
    -- No faster casting against a target at range.
    mob:setMobMod(xi.mobMod.STANDBACK_COOL, 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 26)
    -- Dream Shroud turns this on.
    mob:setMod(xi.mod.UFASTCAST, 0)
    mob:setMod(xi.mod.REGAIN, 55)
    mob:setMobMod(xi.mobMod.DETECTION, xi.detects.SIGHT)

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'DIABOLOS_NIGHTMARE_WS', function(mobArg, skillId, wasExecuted)
        if
            skillId == xi.mobSkill.NIGHTMARE_1 and
            mobArg:getLocalVar('specialNightmare') == 1
        then
            mobArg:setLocalVar('specialNightmare', 0)

            -- Diabolos swings every 3 seconds once the tiles are down.
            mobArg:setDelay(180)

            -- Drop all tiles after Nightmare completes
            local instance = mobArg:getLocalVar('instance')
            local baseOffset = ID.npc.DARKNESS_NAMED_TILE_OFFSET + (instance * 8)

            for index = 0, 7 do
                local tileId = baseOffset + index
                local tile = GetNPCByID(tileId)

                if tile and tile:getAnimation() == xi.animation.CLOSE_DOOR then
                    SendEntityVisualPacket(tileId, tileDropAnimations[index + 1][instance + 1])
                    SendEntityVisualPacket(tileId, 's123')
                    tile:timer(5000, function(tileArg)
                        tileArg:setAnimation(xi.animation.OPEN_DOOR)
                    end)
                end
            end
        end
    end)

    -- Only a finished Ruinous Omen counts. A stunned one comes back once he can act.
    mob:addListener('WEAPONSKILL_STATE_EXIT', 'DIABOLOS_RUINOUS_OMEN_WS', function(mobArg, skillId, wasExecuted)
        if
            skillId == xi.mobSkill.RUINOUS_OMEN_1 and
            wasExecuted
        then
            mobArg:setLocalVar('ruinousOmenUsed', 1)
        end
    end)
end

entity.onMobEngage = function(mob, target)
    -- Begins fight with a draw in on all battlefield members
    if
        mob:getLocalVar('initialDrawIn') == 0 and
        not xi.combat.behavior.isEntityBusy(mob)
    then
        mob:setLocalVar('initialDrawIn', 1)
        local battlefield = mob:getBattlefield()

        if battlefield then
            local inst = mob:getLocalVar('instance')
            local positions = drawInPositions[inst + 1]

            for _, member in ipairs(battlefield:getPlayers()) do
                local randomPos = positions[math.randomInt(1, #positions)]
                mob:drawIn(member, 0, 0, randomPos)
            end
        end
    end
end

entity.onMobFight = function(mob, target)
    local inst = mob:getLocalVar('instance')

    -- Draw in current target if they exceed the Y threshold
    if target:getYPos() > drawInYThresholds[inst + 1] then
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        local positions = drawInPositions[inst + 1]
        local randomPos = positions[math.randomInt(1, #positions)]
        randomPos.rot = target:getRotPos()
        mob:drawIn(target, 0, 0, randomPos)
    else
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    end

    -- Dream Shroud's short cooldown runs out 95 seconds after the last use.
    if
        mob:getLocalVar('dreamShroudEnd') > 0 and
        GetSystemTime() >= mob:getLocalVar('dreamShroudEnd')
    then
        mob:setLocalVar('dreamShroudEnd', 0)
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 26)
    end

    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Trigger Ruinous Omen at set HP percent once per fight. The listener marks it used, so a stunned one comes back.
    if
        mob:getHPP() <= mob:getLocalVar('ruinousOmenPercent') and
        mob:getLocalVar('ruinousOmenUsed') == 0
    then
        mob:useMobAbility(xi.mobSkill.RUINOUS_OMEN_1)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local camisado = mob:getLocalVar('nightmareUsed') == 1 and xi.mobSkill.CAMISADO_2 or xi.mobSkill.CAMISADO_1

    local skills =
    {
        { skill = xi.mobSkill.NIGHTMARE_1,       weight = 31 },
        { skill = xi.mobSkill.NETHER_BLAST_1,    weight = 17 },
        { skill = xi.mobSkill.DREAM_SHROUD_1,    weight = 14 },
        { skill = xi.mobSkill.CACODEMONIA_1,     weight = 12 },
        { skill = xi.mobSkill.NOCTOSHIELD_1,     weight = 12 },
        { skill = xi.mobSkill.SOMNOLENCE_1,      weight = 8  },
        { skill = xi.mobSkill.ULTIMATE_TERROR_1, weight = 4  },
        { skill = camisado,                      weight = 2  },
    }

    local roll = math.randomInt(1, 100)
    local cumulative = 0

    for _, entry in ipairs(skills) do
        cumulative = cumulative + entry.weight
        if roll <= cumulative then
            return entry.skill
        end
    end

    return xi.mobSkill.NOCTOSHIELD_1
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    -- The hook fires once per target hit. The rest runs once per use.
    if target:getID() ~= skill:getTargets()[1]:getID() then
        return
    end

    local skillId = skill:getID()

    -- The first Nightmare at or under the rolled HP drops the tiles.
    if
        skillId == xi.mobSkill.NIGHTMARE_1 and
        mob:getLocalVar('nightmareUsed') == 0 and
        mob:getHPP() <= mob:getLocalVar('nightmarePercent')
    then
        mob:setLocalVar('nightmareUsed', 1)
        mob:setLocalVar('specialNightmare', 1)
    end

    -- Dream Shroud has Diabolos casting every 5 to 9 seconds for 95 seconds.
    -- Casts stay instant for the rest of the spawn.
    -- The old cooldown is still running. This cast skips it.
    if skillId == xi.mobSkill.DREAM_SHROUD_1 then
        mob:setLocalVar('dreamShroudEnd', GetSystemTime() + 95)
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 10)
        mob:setMod(xi.mod.UFASTCAST, 100)

        local castTarget = mob:getTarget()
        if castTarget then
            mob:castSpell(entity.onMobSpellChoose(mob, castTarget))
        end
    end

    -- Camisado follows these moves. 544 until the tiles drop, the heavier 1554 after.
    if
        skillId == xi.mobSkill.ULTIMATE_TERROR_1 or
        skillId == xi.mobSkill.CACODEMONIA_1 or
        skillId == xi.mobSkill.NIGHTMARE_1 or
        skillId == xi.mobSkill.SOMNOLENCE_1
    then
        local camisado = mob:getLocalVar('nightmareUsed') == 1 and xi.mobSkill.CAMISADO_2 or xi.mobSkill.CAMISADO_1
        mob:queue(0, function(mobArg)
            mobArg:useMobAbility(camisado)
        end)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.DISPEL,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [2] = { xi.magic.spell.DRAIN,      target, false, xi.action.type.DRAIN_HP,          nil,                 0, 100 },
        [3] = { xi.magic.spell.ASPIR,      target, false, xi.action.type.DRAIN_MP,          nil,                 0, 100 },
        [4] = { xi.magic.spell.BIO_III,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,       6, 100 },
        [5] = { xi.magic.spell.BLIND,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BLINDNESS, 1, 100 },
        [6] = { xi.magic.spell.SLEEPGA_II, target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
    }

    -- Dream Shroud swaps the list. The ga spells go out even on targets already blind or asleep.
    local shroudSpells =
    {
        [1] = { xi.magic.spell.DRAIN,      target, false, xi.action.type.DRAIN_HP,      nil, 0, 43 },
        [2] = { xi.magic.spell.DISPELGA,   target, false, xi.action.type.DAMAGE_TARGET, nil, 0, 27 },
        [3] = { xi.magic.spell.BLINDGA,    target, false, xi.action.type.DAMAGE_TARGET, nil, 0, 15 },
        [4] = { xi.magic.spell.SLEEPGA_II, target, false, xi.action.type.DAMAGE_TARGET, nil, 0, 15 },
    }

    local listToUse = mob:getLocalVar('dreamShroudEnd') > 0 and shroudSpells or spellList

    return xi.combat.behavior.chooseAction(mob, target, nil, listToUse)
end

return entity
