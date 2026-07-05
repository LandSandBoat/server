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

entity.spawnPoints =
{
    { x = 574.944, y = -20.250, z = 398.044 },
    { x = 575.081, y = -20.212, z = 401.917 },
    { x = 575.150, y = -20.193, z = 403.854 },
    { x = 575.061, y = -20.024, z = 407.646 },
    { x = 574.860, y = -19.789, z = 411.398 },
    { x = 574.437, y = -19.764, z = 413.376 },
    { x = 573.270, y = -19.806, z = 417.435 },
    { x = 574.290, y = -19.406, z = 420.032 },
    { x = 577.499, y = -18.565, z = 421.169 },
    { x = 578.716, y = -18.258, z = 420.995 },
    { x = 579.607, y = -18.103, z = 417.676 },
    { x = 579.958, y = -18.266, z = 414.169 },
    { x = 579.595, y = -18.665, z = 412.226 },
    { x = 578.869, y = -19.463, z = 408.341 },
    { x = 586.698, y = -17.777, z = 404.160 },
    { x = 587.057, y = -17.693, z = 406.042 },
    { x = 586.263, y = -17.534, z = 408.917 },
    { x = 585.373, y = -17.456, z = 411.840 },
    { x = 584.688, y = -17.619, z = 413.423 },
    { x = 583.317, y = -17.946, z = 416.588 },
    { x = 585.758, y = -17.501, z = 416.037 },
    { x = 588.960, y = -16.903, z = 414.743 },
    { x = 590.375, y = -16.657, z = 414.253 },
    { x = 593.206, y = -16.164, z = 413.272 },
    { x = 593.708, y = -16.131, z = 411.042 },
    { x = 593.377, y = -16.228, z = 409.615 },
    { x = 593.064, y = -16.349, z = 406.841 },
    { x = 593.448, y = -16.318, z = 404.230 },
    { x = 593.640, y = -16.302, z = 402.924 },
    { x = 594.297, y = -16.220, z = 399.705 },
    { x = 595.293, y = -16.128, z = 396.851 },
    { x = 597.986, y = -15.990, z = 395.816 },
    { x = 599.332, y = -15.921, z = 395.298 },
    { x = 601.327, y = -15.944, z = 396.589 },
    { x = 610.253, y = -15.740, z = 396.727 },
    { x = 611.305, y = -15.711, z = 397.986 },
    { x = 613.410, y = -15.652, z = 400.505 },
    { x = 613.496, y = -15.615, z = 403.029 },
    { x = 613.338, y = -15.598, z = 404.292 },
    { x = 611.835, y = -15.628, z = 405.258 },
    { x = 602.027, y = -15.916, z = 405.037 },
    { x = 601.369, y = -15.900, z = 406.213 },
    { x = 601.264, y = -15.800, z = 409.571 },
    { x = 602.410, y = -15.722, z = 411.917 },
    { x = 604.808, y = -15.665, z = 413.252 },
    { x = 606.333, y = -15.641, z = 413.605 },
    { x = 610.690, y = -15.612, z = 413.052 },
    { x = 610.845, y = -15.621, z = 412.200 },
    { x = 606.722, y = -15.664, z = 411.476 },
    { x = 598.476, y = -15.750, z = 410.028 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)

    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)

    mob:setMobMod(xi.mobMod.GIL_MIN, 30000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 30000)
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
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
