xi = xi or {}
xi.aoe = xi.aoe or {}

---@class AoeSphere
---@field origin xi.aoe.sphere
---@field radius number

---@class AoeCone
---@field origin? xi.aoe.cone
---@field angle number -- Degrees, usually 45.
---@field distance number -- Max distance at which the cone extends.

---@class AoEProperties
---@field flags? xi.aoe.areaFlags[] -- Special flags affecting AoE properties of the action
---@field affects xi.target[] -- Type of entities affected by the AoE
---@field cone? AoeCone -- Set if conal AoE
---@field sphere? AoeSphere -- Set if sphere AoE

---@enum xi.aoe.sphere
xi.aoe.sphere =
{
    NONE   = 0,
    CASTER = 1, -- Sphere radiates from the caster
    TARGET = 2, -- Sphere radiates from the target
}

---@enum xi.aoe.cone
xi.aoe.cone =
{
    NONE  = 0,
    FRONT = 1, -- Cone in front of caster
    REAR  = 2, -- Cone in back of caster. Pretty much Ixion only until proven otherwise.
}

---@enum xi.aoe.areaFlags
xi.aoe.areaFlags =
{
    NONE           = 0,
    DIVINE_VEIL    = 1, -- Divine Veil turns this spell into a 10y sphere AoE
    MANIFESTATION  = 2, -- Manifestation turns this spell into a 10y sphere AoE
    ACCESSION      = 4, -- Accession turns this spell into a 10y sphere AoE
    THEURGIC_FOCUS = 8, -- Theurgic Focus reduces this spell radius by half
}
