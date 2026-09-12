-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Hydra
-- !pos -282 -24 -1 51
-----------------------------------
mixins = { require('scripts/mixins/families/hydra'), }
-----------------------------------
---@type TMobEntity
local entity = {}

local drawInPositions =
{
    { -279.879, -24.5,   -1.103 },
    { -268.900, -24.0,  -11.148 },
    { -279.844, -24.25, -11.462 },
    { -268.952, -24.25,  -0.583 },
}

local arenaBoundaries =
{
    { { -286.242, -24.521 }, { -251.551, -31.676 } },
    { { -251.551, -31.676 }, { -235.529,   1.043 } },
    { { -235.529,   1.043 }, { -278.562,  18.208 } },
    { { -278.562,  18.208 }, { -286.242, -24.521 } },
}

entity.spawnPoints =
{
    { x = -276.309, y = -24.000, z =   0.997 },
    { x = -271.083, y = -23.750, z =   0.008 },
    { x = -265.027, y = -23.566, z =  -3.346 },
    { x = -264.331, y = -23.500, z =  -8.112 },
    { x = -269.145, y = -23.500, z = -11.040 },
    { x = -275.083, y = -23.645, z = -12.815 },
    { x = -275.782, y = -23.526, z = -19.857 },
    { x = -270.596, y = -23.625, z = -22.021 },
    { x = -262.854, y = -24.000, z = -24.542 },
}

local regenPerHead =
{
    [0] = 150,
    [1] = 70,
    [2] = 10,
}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(48, 72) * 3600) -- 48 - 72 hours with 1 hour windows
    xi.mob.updateNMSpawnPoint(mob)

    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.CURSE)

    mob:setMod(xi.mod.FIRE_RES_RANK, 9)
    mob:setMod(xi.mod.ICE_RES_RANK, 9)
    mob:setMod(xi.mod.WIND_RES_RANK, 9)
    mob:setMod(xi.mod.EARTH_RES_RANK, 6)
    mob:setMod(xi.mod.THUNDER_RES_RANK, 6)
    mob:setMod(xi.mod.WATER_RES_RANK, 6)
    mob:setMod(xi.mod.LIGHT_RES_RANK, 6)
    mob:setMod(xi.mod.DARK_RES_RANK, 6)

    mob:setMod(xi.mod.BLIND_RES_RANK, 6)
    mob:setMod(xi.mod.POISON_RES_RANK, 6)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 9)
    mob:setMod(xi.mod.SLOW_RES_RANK, 6)

    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
end

entity.onMobSpawn = function(mob)
    mob:setBaseSpeed(32)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)
    mob:setMod(xi.mod.MDEF, 30)

    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
    mob:setMod(xi.mod.DEF, 578)
    mob:setMod(xi.mod.ATT, 850)

    mob:setMod(xi.mod.UDMGBREATH, -10000)
    mob:setMod(xi.mod.UDMGMAGIC, -2500)
    mob:setMod(xi.mod.PIERCE_SDT, -5000)
    mob:setMod(xi.mod.IMPACT_SDT, -5000)
    mob:setMod(xi.mod.HTH_SDT, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
end

entity.onMobFight = function(mob, target)
    local targetPos = target:getPos()
    local spawnPos = mob:getSpawnPos()

    if mob:getHPP() <= 95 then
        mob:setMod(xi.mod.REGAIN, 100)
    end

    mob:setMod(xi.mod.REGEN, regenPerHead[mob:getAnimationSub()])

    local pos = utils.randomEntry(drawInPositions)
    local drawInTable =
    {
        conditions =
        {
            not utils.sameSideOfLine(arenaBoundaries[1], targetPos, spawnPos),
            not utils.sameSideOfLine(arenaBoundaries[2], targetPos, spawnPos),
            not utils.sameSideOfLine(arenaBoundaries[3], targetPos, spawnPos),
            not utils.sameSideOfLine(arenaBoundaries[4], targetPos, spawnPos),
        },
        position = { pos[1], pos[2], pos[3], targetPos.rot },
        wait = 1,
    }

    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            if utils.drawIn(target, drawInTable) then
                mob:addTP(3000)
            end

            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList = {}
    local skillInfo =
    {
        [1] = { xi.mobSkill.TREMBLING,       100, 2, true,  true  },
        [2] = { xi.mobSkill.SERPENTINE_TAIL, 100, 2, true,  false },
        [3] = { xi.mobSkill.BAROFIELD,       100, 2, false, true  },
        [4] = { xi.mobSkill.NERVE_GAS,        50, 0, true,  true  },
        [5] = { xi.mobSkill.PYRIC_BULWARK,   100, 0, true,  true  },
        [6] = { xi.mobSkill.PYRIC_BLAST,     100, 0, false, true  },
        [7] = { xi.mobSkill.POLAR_BULWARK,   100, 1, true,  true  },
        [8] = { xi.mobSkill.POLAR_BLAST,     100, 1, false, true  },
    }

    local hpp         = mob:getHPP()
    local brokenHeads = mob:getAnimationSub()
    local isInFront   = target:isInfront(mob, 128)
    local isBehind    = target:isBehind(mob, 128)

    for i = 1, #skillInfo do
        if
            hpp <= skillInfo[i][2] and
            brokenHeads <= skillInfo[i][3] and
            (skillInfo[i][4] or isInFront) and
            (skillInfo[i][5] or isBehind)
        then
            table.insert(skillList, skillInfo[i][1])
        end
    end

    return skillList[math.randomInt(1, #skillList)]
end

entity.onMobDisengage = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMod(xi.mod.REGAIN, 0)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.HYDRA_HEADHUNTER)
    end
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.randomInt(48, 72) * 3600) -- 48 to 72 hours, in 1 hour windows
end

return entity
