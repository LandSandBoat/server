-----------------------------------
-- Area: Spire of Vahzl
--  Mob: Cumulator
-----------------------------------
---@type TMobEntity
local entity = {}

local function engageNextMob(mob, target)
    if not target then
        return
    end

    local nextMob = GetMobByID(mob:getID() - 5) -- Procreator

    if not nextMob then
        return
    end

    if
        nextMob:isAlive() and
        not nextMob:isEngaged()
    then
        nextMob:updateEnmity(target)
    end
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.STORETP, 62)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local tpMoves =
    {
        xi.mobSkill.CAROUSEL_1,
        xi.mobSkill.EMPTY_THRASH,
        xi.mobSkill.IMPALEMENT,
    }

    if mob:getHPP() > 35 then
        table.insert(tpMoves, xi.mobSkill.MATERIAL_FEND)
        table.insert(tpMoves, xi.mobSkill.MURK)
        table.insert(tpMoves, xi.mobSkill.PROMYVION_BRUME_2)
    end

    return tpMoves[math.randomInt(1, #tpMoves)]
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() > 35 then
        mob:setMod(xi.mod.REGAIN, 0)
    else
        mob:setMod(xi.mod.REGAIN, 100)
    end

    if mob:getHPP() < 20 then -- Procreator engages < 20% HP.
        engageNextMob(mob, target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        engageNextMob(mob, player)
    end
end

return entity
