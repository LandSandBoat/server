-----------------------------------
-- Area: Boneyard Gully
--  Mob: Tuchulcha
--  ENM: Sheep in Antlion's Clothing
-----------------------------------
mixins = { require('scripts/mixins/families/antlion_ambush') }
local ID = zones[xi.zone.BONEYARD_GULLY]
-----------------------------------
---@type TMobEntity
local entity = {}

local sandpitID = 276
local antlionPositions =
{
    [1] =
    {
        { -517,    0, -521, 171 },
        { -534,    0, -460, 171 },
        { -552,  2.2, -440, 171 },
        { -572, -3.6, -464, 171 },
        { -573,  2.2, -427, 171 },
        { -562,    0, -484, 171 },
        { -593,    0, -480, 171 },
        { -610, -1.5, -490, 171 },
    },

    [2] =
    {
        {   43,    0,  40, 7 },
        {   26,    0, 100, 7 },
        {    7,  2.2, 118, 7 },
        {  -13, -3.6,  95, 7 },
        {  -13,  2.2, 133, 7 },
        { -2.3,    0,  76, 7 },
        {  -33,    0,  79, 7 },
        {  -54, -1.5,  67, 7 },
    },

    [3] =
    {
        { 522,    0, 521, 240 },
        { 506,    0, 580, 240 },
        { 466,  2.2, 614, 240 },
        { 467, -3.6,  57, 240 },
        { 488,  2.2, 598, 240 },
        { 478,    0, 557, 240 },
        { 446,    0, 558, 240 },
        { 430, -1.5, 550, 240 },
    },
}

entity.onMobSpawn = function(mob)
    -- Aggros via ambush, not superlinking
    mob:setMobMod(xi.mobMod.SUPERLINK, 0)

    -- Used with HPP to keep track of the number of Sandpits
    mob:setLocalVar('Sandpits', 0)

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'TUCHULCHA_SANDPIT', function(tuchulcha, skillID)
        if skillID == sandpitID then
            tuchulcha:disengage()
            tuchulcha:setMobMod(xi.mobMod.NO_MOVE, 1)
            tuchulcha:setMobMod(xi.mobMod.NO_REST, 1)
            local posIndex = tuchulcha:getLocalVar('sand_pit' .. tuchulcha:getLocalVar('Sandpits'))
            local coords   = antlionPositions[tuchulcha:getBattlefield():getArea()][posIndex]
            local players  = tuchulcha:getBattlefield():getPlayers()
            for _, char in pairs(players) do
                char:messageSpecial(ID.text.TUCHULCHA_SANDPIT)
                char:disengage()
                if char:hasPet() then
                    char:petRetreat()
                end
            end

            -- ensure the client doesn't get the position update
            tuchulcha:setStatus(xi.status.INVISIBLE)
            tuchulcha:setPos(coords)
        end
    end)

    mob:addListener('ENGAGE', 'TUCHULCHA_ENGAGE', function(mobArg)
        if mobArg:getStatus() ~= xi.status.UPDATE then
            mobArg:setStatus(xi.status.UPDATE)
        end
    end)
end

-- Reset restHP when re-engaging after a sandpit
entity.onMobEngage = function(mob, target)
    if mob:getMobMod(xi.mobMod.NO_REST) == 1 then
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        mob:setMobMod(xi.mobMod.NO_REST, 0)
    end
end

entity.onMobFight = function(mob, target)
    -- Every 25% of its HP Tuchulcha will bury itself under the sand
    -- accompanied by use of the ability Sandpit
    if
        (mob:getHPP() < 75 and mob:getLocalVar('Sandpits') == 0) or
        (mob:getHPP() < 50 and mob:getLocalVar('Sandpits') == 1) or
        (mob:getHPP() < 25 and mob:getLocalVar('Sandpits') == 2)
    then
        mob:setLocalVar('Sandpits', mob:getLocalVar('Sandpits') + 1)
        mob:useMobAbility(sandpitID)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- Used to grab the mob IDs
    -- Despawn the hunters
    if optParams.isKiller then
        local mobOffset = mob:getID()
        for hunterMobId = mobOffset + 1, mobOffset + 3 do
            DespawnMob(hunterMobId)
        end
    end
end

return entity
