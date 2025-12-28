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

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
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

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.KHIMAIRA_CARVER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 to 72 hours, in 1-hour increments
end

return entity
