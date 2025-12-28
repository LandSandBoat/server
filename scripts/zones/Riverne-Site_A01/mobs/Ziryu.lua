-----------------------------------
-- Area: Riverne - Site A01
-- Mob: Ziryu
-- Notes: in Ouryu Cometh
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_A01]
-----------------------------------
---@type TMobEntity
local entity = {}

local ziryuOne =
{
    { 46.836, 76.828, -758.276 },
    { 26.248, 76.607, -750.256 },
    { 42.179, 76.290, -752.683 },
    { 26.127, 76.550, -767.194 },
    { 35.687, 76.152, -757.707 },
    { 48.250, 76.524, -766.964 },
    { 50.825, 76.781, -756.612 },
    { 38.753, 76.809, -771.376 },
}

local ziryuTwo =
{
    { -5.680, 76.098, -753.375 },
    { -7.673, 76.109, -753.720 },
    { -5.063, 76.632, -769.115 },
    {  5.228, 76.399, -767.280 },
    {  5.263, 76.308, -757.192 },
    { -4.365, 76.112, -750.562 },
    { -0.636, 76.000, -763.672 },
}

local ziryuThree =
{
    {  0.744, 76.462, -712.730 },
    {  3.663, 76.234, -710.823 },
    {  0.834, 76.032, -721.327 },
    {  9.013, 76.413, -722.767 },
    { -2.091, 76.000, -718.037 },
    { 10.238, 76.550, -724.555 },
}

local ziryuFour =
{
    { 10.129, 65.914, -736.797 },
    {  9.715, 76.785, -744.856 },
    { 22.027, 76.512, -730.651 },
    { 36.108, 76.590, -710.141 },
    { 49.704, 76.034, -722.611 },
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 30)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(120)
    local randspawn1 = ziryuOne[math.random((1), (8))]
    local randspawn2 = ziryuTwo[math.random((1), (7))]
    local randspawn3 = ziryuThree[math.random((1), (6))]
    local randspawn4 = ziryuFour[math.random((1), (5))]

    if mob:getID() == ID.mob.ZIRYU[1] then
        mob:setSpawn(randspawn1[1], randspawn1[2], randspawn1[3])
    elseif mob:getID() == ID.mob.ZIRYU[2] then
        mob:setSpawn(randspawn2[1], randspawn2[2], randspawn2[3])
    elseif mob:getID() == ID.mob.ZIRYU[3] then
        mob:setSpawn(randspawn3[1], randspawn3[2], randspawn3[3])
    elseif mob:getID() == ID.mob.ZIRYU[4] then
        mob:setSpawn(randspawn4[1], randspawn4[2], randspawn4[3])
    end
end

return entity
