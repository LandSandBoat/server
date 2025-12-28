-----------------------------------
-- Area: The Shrouded Maw
--  Mob: Diabolos (Dynamis-Nightmare)
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
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    -- Cache instance calculation once on spawn
    local inst = math.floor((mob:getID() - ID.mob.DIABOLOS) / 7)
    mob:setLocalVar('instance', inst)
    mob:setLocalVar('nightmarePercent', math.random(25, 75))
    mob:setMagicCastingEnabled(false)

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'DIABOLOS_NIGHTMARE_WS', function(mobArg, skillID)
        if
            skillID == xi.mobSkill.NIGHTMARE_1 and
            mobArg:getLocalVar('specialNightmare') == 1
        then
            mobArg:setLocalVar('specialNightmare', 0)

            -- Drop all tiles after Nightmare completes
            local instance = mobArg:getLocalVar('instance')
            local baseOffset = ID.npc.DARKNESS_NAMED_TILE_OFFSET + (instance * 8)

            for index = 0, 7 do
                local tileId = baseOffset + index
                local tile = GetNPCByID(tileId)

                if tile and tile:getAnimation() == xi.anim.CLOSE_DOOR then
                    SendEntityVisualPacket(tileId, tileDropAnimations[index + 1][instance + 1])
                    SendEntityVisualPacket(tileId, 's123')
                    tile:timer(5000, function(tileArg)
                        tileArg:setAnimation(xi.anim.OPEN_DOOR)
                    end)
                end
            end
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
                local randomPos = positions[math.random(#positions)]
                mob:drawIn(member, 0, 0, randomPos)
            end
        end
    end

    -- Enable magic casting after 20 seconds
    mob:timer(20000, function(mobArg)
        mobArg:setMagicCastingEnabled(true)
    end)
end

entity.onMobFight = function(mob, target)
    local inst = mob:getLocalVar('instance')
    local currentHP = mob:getHPP()

    -- Trigger Nightmare at set HP percent once per fight
    if
        currentHP <= mob:getLocalVar('nightmarePercent') and
        mob:getLocalVar('nightmareUsed') == 0
    then
        mob:setLocalVar('nightmareUsed', 1)
        mob:setLocalVar('specialNightmare', 1)
        mob:useMobAbility(xi.mobSkill.NIGHTMARE_1)
    end

    -- Enable regain below 35% HP
    if currentHP <= 35 then
        mob:setMod(xi.mod.REGAIN, 55)
    else
        mob:setMod(xi.mod.REGAIN, 0)
    end

    -- Draw in current target if they exceed the Y threshold
    if target:getYPos() > drawInYThresholds[inst + 1] then
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        local positions = drawInPositions[inst + 1]
        local randomPos = positions[math.random(#positions)]
        randomPos.rot = target:getRotPos()
        mob:drawIn(target, 0, 0, randomPos)
    else
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    end
end

entity.onMobMobskillChoose = function(mob, target)
    local skills =
    {
        { skill = xi.mobSkill.NOCTOSHIELD_1,     weight = 50 },
        { skill = xi.mobSkill.ULTIMATE_TERROR_1, weight = 30 },
        { skill = xi.mobSkill.NIGHTMARE_1,       weight = 20 },
    }

    local roll = math.random(1, 100)
    local cumulative = 0

    for _, entry in ipairs(skills) do
        cumulative = cumulative + entry.weight
        if roll <= cumulative then
            return entry.skill
        end
    end

    return xi.mobSkill.NOCTOSHIELD_1
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()

    if
        skillId == xi.mobSkill.NIGHTMARE_1 or
        skillId == xi.mobSkill.ULTIMATE_TERROR_1
    then
        mob:queue(0, function(mobArg)
            mobArg:useMobAbility(xi.mobSkill.CAMISADO_1)
        end)
    end
end

entity.onMobSpellChoose = function(mob, target)
    local spellList =
    {
        xi.magic.spell.DRAIN,
        xi.magic.spell.ASPIR,
        xi.magic.spell.SLEEP_II,
        xi.magic.spell.SLEEPGA,
        xi.magic.spell.BLIND,
    }

    return spellList[math.random(1, #spellList)]
end

return entity
