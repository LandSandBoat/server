-----------------------------------
-- Area: Caedarva Mire
--   NM: Khimaira
-----------------------------------
mixins =
{
    require('scripts/mixins/families/khimaira'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(48, 72) * 3600) -- 48 - 72 hours with 1 hour windows

    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)

    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
end

entity.onMobRoam = function(mob)
    if mob:isFollowingPath() then
        return
    end

    local currentTime = GetSystemTime()

    if currentTime < mob:getLocalVar('roarTimer') then
        return
    end

    mob:useMobAbility(xi.mobSkill.ROAR_KHIMAIRA)
    mob:setLocalVar('roarTimer', currentTime + math.randomInt(150, 210))
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)

    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MODIFIER, 53) -- 140 total weapon damage.
    mob:setMod(xi.mod.ATT, 681) -- 740 total attack.
    mob:setMod(xi.mod.DEF, 520) -- 570 total defense.
    mob:setMod(xi.mod.STORETP, 80) -- 10 hits to 1000 TP.

    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -2500)

    mob:setMod(xi.mod.SILENCE_RES_RANK, 7)
    mob:setMod(xi.mod.POISON_RES_RANK, 7)
    mob:setMod(xi.mod.SLOW_RES_RANK, 7)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 7)
    mob:setMod(xi.mod.BLIND_RES_RANK, 7)
    mob:setMod(xi.mod.BIND_RES_RANK, 7)
    mob:setMod(xi.mod.GRAVITY_RES_RANK, 7)

    mob:setMod(xi.mod.CURSE_MEVA, 1000)
    mob:setLocalVar('roarTimer', GetSystemTime() + math.randomInt(150, 210))
end

entity.onMobFight = function(mob, target)
    local targetPos = target:getPos()
    local drawInPositions =
    {
        { 575.152, -19.639, 413.799, targetPos.rot },
        { 576.142, -20.050, 407.218, targetPos.rot },
        { 601.734, -15.784, 407.487, targetPos.rot },
        { 592.576, -16.434, 399.715, targetPos.rot },
        { 584.961,     -18, 397.781, targetPos.rot },
        { 592.576, -16.434, 399.715, targetPos.rot },
        {  582.47,     -18, 415.788, targetPos.rot },
        { 589.504, -16.844, 413.867, targetPos.rot },
        { 599.341,     -16, 398.024, targetPos.rot },
        { 615.569, -15.528, 398.819, targetPos.rot },
    }
    local drawInTable =
    {
        conditions =
        {
            target:getZPos() > 420,
            target:getZPos() < 394,
        },
        position = utils.randomEntry(drawInPositions),
        wait = 3,
    }
    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.TENEBROUS_MIST,
        xi.mobSkill.THUNDERSTRIKE,
        xi.mobSkill.TOURBILLION,
        xi.mobSkill.DREADSTORM,
    }

    if target:isInfront(mob, 128) then
        table.insert(skillList, xi.mobSkill.FOSSILIZING_BREATH)
    end

    if target:isBehind(mob) then
        table.insert(skillList, xi.mobSkill.PLAGUE_SWIPE)
    end

    if mob:getHPP() <= 37 then
        table.insert(skillList, xi.mobSkill.FULMINATION)
    end

    return skillList[math.randomInt(1, #skillList)]
end

entity.onMobDisengage = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.KHIMAIRA_CARVER)
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(48, 72) * 3600) -- 48 to 72 hours, in 1-hour increments
end

return entity
