-----------------------------------
-- Augments
-----------------------------------
xi = xi or {}
xi.data = xi.data or {}
xi.data.augments = xi.data.augments or {}

-- TODO: Not implemented, treat this as documentation and rework as needed
-- Evolith augment IDs ('Augment' in the evolith exdata) are 0 to 325
-- Source: FFXiMain.dll lookup table of 1024 entries with 20-byte records. Signature: 00 04 13 00 04 05 06 07 08 09 0A 0C 0C 0C 0C 0C 0C 0C 0C 0C
-- PPPP SSSS VV VV VV VV VV VV VV VV VV VV VV VV VV VV VV VV
-- PP = uint16 representing the prefix for the augment (i.e. Vs. beasts)
-- SS = uint16 representing the suffix for the augment (i.e. Attack+)
-- VV = 16 tiers of values (but Evoliths only really go up to tier 7)
-- Example: Evolith with augment ID 120 and bonus 3
-- -> Lookup table says prefix 1036 and suffix 20 and the 4th tier is '7'
-- -> 1036 and 20 are parsed from the main mnc2 augment DAT table (ROM/119/57.DAT)
-- -> 1036: Vs. dragons
-- ->   20: Rng. Acc.+
-- -> Complete augment: Vs. dragons: Rng. Acc.+7
-- Notes:
--   - Certain augments stored in the client cannot be produced server side.
--     - Enmity+ only exists for Katana weaponskills.
--     - There's no Lightning aligned enfeebling effects
--   - Certain augments have NO prefix

---@alias EvolithAugment { [1]: xi.evolith.prefix, [2]: xi.evolith.suffix, [3]: integer[] }

-- Table used to retrieve effects and power for a given evolith augment ID
---@type table<integer, EvolithAugment>
xi.data.augments.evolith =
{
    [  1] = { xi.evolith.prefix.VS_BEASTS,                 xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [  2] = { xi.evolith.prefix.VS_BEASTS,                 xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [  3] = { xi.evolith.prefix.VS_BEASTS,                 xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [  4] = { xi.evolith.prefix.VS_BEASTS,                 xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [  5] = { xi.evolith.prefix.VS_BEASTS,                 xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [  6] = { xi.evolith.prefix.VS_BEASTS,                 xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [  7] = { xi.evolith.prefix.VS_BEASTS,                 xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [  8] = { xi.evolith.prefix.VS_BEASTS,                 xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [  9] = { xi.evolith.prefix.VS_BEASTS,                 xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 10] = { xi.evolith.prefix.VS_BEASTS,                 xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 11] = { xi.evolith.prefix.VS_PLANTOIDS,              xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 12] = { xi.evolith.prefix.VS_PLANTOIDS,              xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [ 13] = { xi.evolith.prefix.VS_PLANTOIDS,              xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 14] = { xi.evolith.prefix.VS_PLANTOIDS,              xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [ 15] = { xi.evolith.prefix.VS_PLANTOIDS,              xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 16] = { xi.evolith.prefix.VS_PLANTOIDS,              xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 17] = { xi.evolith.prefix.VS_PLANTOIDS,              xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [ 18] = { xi.evolith.prefix.VS_PLANTOIDS,              xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 19] = { xi.evolith.prefix.VS_PLANTOIDS,              xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 20] = { xi.evolith.prefix.VS_PLANTOIDS,              xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 21] = { xi.evolith.prefix.VS_VERMIN,                 xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 22] = { xi.evolith.prefix.VS_VERMIN,                 xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [ 23] = { xi.evolith.prefix.VS_VERMIN,                 xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 24] = { xi.evolith.prefix.VS_VERMIN,                 xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [ 25] = { xi.evolith.prefix.VS_VERMIN,                 xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 26] = { xi.evolith.prefix.VS_VERMIN,                 xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 27] = { xi.evolith.prefix.VS_VERMIN,                 xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [ 28] = { xi.evolith.prefix.VS_VERMIN,                 xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 29] = { xi.evolith.prefix.VS_VERMIN,                 xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 30] = { xi.evolith.prefix.VS_VERMIN,                 xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 31] = { xi.evolith.prefix.VS_LIZARDS,                xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 32] = { xi.evolith.prefix.VS_LIZARDS,                xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [ 33] = { xi.evolith.prefix.VS_LIZARDS,                xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 34] = { xi.evolith.prefix.VS_LIZARDS,                xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [ 35] = { xi.evolith.prefix.VS_LIZARDS,                xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 36] = { xi.evolith.prefix.VS_LIZARDS,                xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 37] = { xi.evolith.prefix.VS_LIZARDS,                xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [ 38] = { xi.evolith.prefix.VS_LIZARDS,                xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 39] = { xi.evolith.prefix.VS_LIZARDS,                xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 40] = { xi.evolith.prefix.VS_LIZARDS,                xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 41] = { xi.evolith.prefix.VS_BIRDS,                  xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 42] = { xi.evolith.prefix.VS_BIRDS,                  xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [ 43] = { xi.evolith.prefix.VS_BIRDS,                  xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 44] = { xi.evolith.prefix.VS_BIRDS,                  xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [ 45] = { xi.evolith.prefix.VS_BIRDS,                  xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 46] = { xi.evolith.prefix.VS_BIRDS,                  xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 47] = { xi.evolith.prefix.VS_BIRDS,                  xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [ 48] = { xi.evolith.prefix.VS_BIRDS,                  xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 49] = { xi.evolith.prefix.VS_BIRDS,                  xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 50] = { xi.evolith.prefix.VS_BIRDS,                  xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 51] = { xi.evolith.prefix.VS_AMORPHS,                xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 52] = { xi.evolith.prefix.VS_AMORPHS,                xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [ 53] = { xi.evolith.prefix.VS_AMORPHS,                xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 54] = { xi.evolith.prefix.VS_AMORPHS,                xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [ 55] = { xi.evolith.prefix.VS_AMORPHS,                xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 56] = { xi.evolith.prefix.VS_AMORPHS,                xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 57] = { xi.evolith.prefix.VS_AMORPHS,                xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [ 58] = { xi.evolith.prefix.VS_AMORPHS,                xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 59] = { xi.evolith.prefix.VS_AMORPHS,                xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 60] = { xi.evolith.prefix.VS_AMORPHS,                xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 61] = { xi.evolith.prefix.VS_AQUANS,                 xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 62] = { xi.evolith.prefix.VS_AQUANS,                 xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [ 63] = { xi.evolith.prefix.VS_AQUANS,                 xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 64] = { xi.evolith.prefix.VS_AQUANS,                 xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [ 65] = { xi.evolith.prefix.VS_AQUANS,                 xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 66] = { xi.evolith.prefix.VS_AQUANS,                 xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 67] = { xi.evolith.prefix.VS_AQUANS,                 xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [ 68] = { xi.evolith.prefix.VS_AQUANS,                 xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 69] = { xi.evolith.prefix.VS_AQUANS,                 xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 70] = { xi.evolith.prefix.VS_AQUANS,                 xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 71] = { xi.evolith.prefix.VS_UNDEAD,                 xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 72] = { xi.evolith.prefix.VS_UNDEAD,                 xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [ 73] = { xi.evolith.prefix.VS_UNDEAD,                 xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 74] = { xi.evolith.prefix.VS_UNDEAD,                 xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [ 75] = { xi.evolith.prefix.VS_UNDEAD,                 xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 76] = { xi.evolith.prefix.VS_UNDEAD,                 xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 77] = { xi.evolith.prefix.VS_UNDEAD,                 xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [ 78] = { xi.evolith.prefix.VS_UNDEAD,                 xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 79] = { xi.evolith.prefix.VS_UNDEAD,                 xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 80] = { xi.evolith.prefix.VS_UNDEAD,                 xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 81] = { xi.evolith.prefix.VS_ELEMENTALS,             xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 82] = { xi.evolith.prefix.VS_ELEMENTALS,             xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [ 83] = { xi.evolith.prefix.VS_ELEMENTALS,             xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 84] = { xi.evolith.prefix.VS_ELEMENTALS,             xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [ 85] = { xi.evolith.prefix.VS_ELEMENTALS,             xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 86] = { xi.evolith.prefix.VS_ELEMENTALS,             xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 87] = { xi.evolith.prefix.VS_ELEMENTALS,             xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [ 88] = { xi.evolith.prefix.VS_ELEMENTALS,             xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 89] = { xi.evolith.prefix.VS_ELEMENTALS,             xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 90] = { xi.evolith.prefix.VS_ELEMENTALS,             xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 91] = { xi.evolith.prefix.VS_ARCANA,                 xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [ 92] = { xi.evolith.prefix.VS_ARCANA,                 xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [ 93] = { xi.evolith.prefix.VS_ARCANA,                 xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 94] = { xi.evolith.prefix.VS_ARCANA,                 xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [ 95] = { xi.evolith.prefix.VS_ARCANA,                 xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 96] = { xi.evolith.prefix.VS_ARCANA,                 xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [ 97] = { xi.evolith.prefix.VS_ARCANA,                 xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [ 98] = { xi.evolith.prefix.VS_ARCANA,                 xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [ 99] = { xi.evolith.prefix.VS_ARCANA,                 xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [100] = { xi.evolith.prefix.VS_ARCANA,                 xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [101] = { xi.evolith.prefix.VS_DEMONS,                 xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [102] = { xi.evolith.prefix.VS_DEMONS,                 xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [103] = { xi.evolith.prefix.VS_DEMONS,                 xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [104] = { xi.evolith.prefix.VS_DEMONS,                 xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [105] = { xi.evolith.prefix.VS_DEMONS,                 xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [106] = { xi.evolith.prefix.VS_DEMONS,                 xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [107] = { xi.evolith.prefix.VS_DEMONS,                 xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [108] = { xi.evolith.prefix.VS_DEMONS,                 xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [109] = { xi.evolith.prefix.VS_DEMONS,                 xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [110] = { xi.evolith.prefix.VS_DEMONS,                 xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [111] = { xi.evolith.prefix.VS_DRAGONS,                xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [112] = { xi.evolith.prefix.VS_DRAGONS,                xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [113] = { xi.evolith.prefix.VS_DRAGONS,                xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [114] = { xi.evolith.prefix.VS_DRAGONS,                xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [115] = { xi.evolith.prefix.VS_DRAGONS,                xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [116] = { xi.evolith.prefix.VS_DRAGONS,                xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [117] = { xi.evolith.prefix.VS_DRAGONS,                xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [118] = { xi.evolith.prefix.VS_DRAGONS,                xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [119] = { xi.evolith.prefix.VS_DRAGONS,                xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [120] = { xi.evolith.prefix.VS_DRAGONS,                xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [121] = { xi.evolith.prefix.VS_EMPTY,                  xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [122] = { xi.evolith.prefix.VS_EMPTY,                  xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [123] = { xi.evolith.prefix.VS_EMPTY,                  xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [124] = { xi.evolith.prefix.VS_EMPTY,                  xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [125] = { xi.evolith.prefix.VS_EMPTY,                  xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [126] = { xi.evolith.prefix.VS_EMPTY,                  xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [127] = { xi.evolith.prefix.VS_EMPTY,                  xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [128] = { xi.evolith.prefix.VS_EMPTY,                  xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [129] = { xi.evolith.prefix.VS_EMPTY,                  xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [130] = { xi.evolith.prefix.VS_EMPTY,                  xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [131] = { xi.evolith.prefix.VS_LUMINIANS,              xi.evolith.suffix.ATTACK,                             {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [132] = { xi.evolith.prefix.VS_LUMINIANS,              xi.evolith.suffix.DEFENSE,                            {   2,   4,   6,   8,  10,  12,  15,  18,  18,  18,  18,  18,  18,  18,  18,  18 } },
    [133] = { xi.evolith.prefix.VS_LUMINIANS,              xi.evolith.suffix.ACCURACY,                           {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [134] = { xi.evolith.prefix.VS_LUMINIANS,              xi.evolith.suffix.EVASION,                            {   3,   4,   5,   6,   8,  10,  13,  16,  16,  16,  16,  16,  16,  16,  16,  16 } },
    [135] = { xi.evolith.prefix.VS_LUMINIANS,              xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [136] = { xi.evolith.prefix.VS_LUMINIANS,              xi.evolith.suffix.MAGIC_DEFENSE_BONUS,                {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [137] = { xi.evolith.prefix.VS_LUMINIANS,              xi.evolith.suffix.MAGIC_ACCURACY,                     {   2,   2,   3,   4,   5,   6,   7,   9,   9,   9,   9,   9,   9,   9,   9,   9 } },
    [138] = { xi.evolith.prefix.VS_LUMINIANS,              xi.evolith.suffix.MAGIC_EVASION,                      {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [139] = { xi.evolith.prefix.VS_LUMINIANS,              xi.evolith.suffix.RANGED_ATTACK,                      {   4,   5,   6,   7,   8,   9,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [140] = { xi.evolith.prefix.VS_LUMINIANS,              xi.evolith.suffix.RANGED_ACCURACY,                    {   2,   3,   4,   5,   7,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [141] = { xi.evolith.prefix.MIGHTY_STRIKES,            xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [142] = { xi.evolith.prefix.HUNDRED_FISTS,             xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [143] = { xi.evolith.prefix.BENEDICTION,               xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [144] = { xi.evolith.prefix.MANAFONT,                  xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [145] = { xi.evolith.prefix.CHAINSPELL,                xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [146] = { xi.evolith.prefix.PERFECT_DODGE,             xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [147] = { xi.evolith.prefix.INVINCIBLE,                xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [148] = { xi.evolith.prefix.BLOOD_WEAPON,              xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [149] = { xi.evolith.prefix.FAMILIAR,                  xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [150] = { xi.evolith.prefix.SOUL_VOICE,                xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [151] = { xi.evolith.prefix.EAGLE_EYE_SHOT,            xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [152] = { xi.evolith.prefix.MEIKYO_SHISUI,             xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [153] = { xi.evolith.prefix.MIJIN_GAKURE,              xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [154] = { xi.evolith.prefix.SPIRIT_SURGE,              xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [155] = { xi.evolith.prefix.ASTRAL_FLOW,               xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [156] = { xi.evolith.prefix.AZURE_LORE,                xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [157] = { xi.evolith.prefix.WILD_CARD,                 xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [158] = { xi.evolith.prefix.OVERDRIVE,                 xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [159] = { xi.evolith.prefix.TRANCE,                    xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [160] = { xi.evolith.prefix.TABULA_RASA,               xi.evolith.suffix.ABILITY_DELAY,                      {   1,   1,   1,   2,   2,   3,   3,   4,   4,   4,   4,   4,   4,   4,   4,   4 } },
    [161] = { xi.evolith.prefix.HAND_TO_HAND_WS,           xi.evolith.suffix.ENMITY,                             { 255, 255, 254, 253, 252, 251, 250, 248, 248, 248, 248, 248, 248, 248, 248, 248 } },
    [162] = { xi.evolith.prefix.HAND_TO_HAND_WS,           xi.evolith.suffix.TP_BONUS,                           {   2,   4,   6,   9,  12,  16,  20,  25,  25,  25,  25,  25,  25,  25,  25,  25 } },
    [163] = { xi.evolith.prefix.DAGGER_WS,                 xi.evolith.suffix.ATTACK,                             {   2,   4,   6,   9,  12,  16,  20,  25,  25,  25,  25,  25,  25,  25,  25,  25 } },
    [164] = { xi.evolith.prefix.DAGGER_WS,                 xi.evolith.suffix.TRIPLE_ATTACK,                      {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [165] = { xi.evolith.prefix.SWORD_WS,                  xi.evolith.suffix.ATTACK,                             {   2,   4,   6,   8,  11,  14,  17,  20,  20,  20,  20,  20,  20,  20,  20,  20 } },
    [166] = { xi.evolith.prefix.SWORD_WS,                  xi.evolith.suffix.CRITICAL_HIT_RATE,                  {   1,   1,   2,   3,   4,   5,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8 } },
    [167] = { xi.evolith.prefix.GREAT_SWORD_WS,            xi.evolith.suffix.ACCURACY,                           {   1,   2,   4,   6,   8,  10,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [168] = { xi.evolith.prefix.GREAT_SWORD_WS,            xi.evolith.suffix.DOUBLE_ATTACK,                      {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [169] = { xi.evolith.prefix.AXE_WS,                    xi.evolith.suffix.ATTACK,                             {   2,   4,   6,   8,  11,  14,  17,  20,  20,  20,  20,  20,  20,  20,  20,  20 } },
    [170] = { xi.evolith.prefix.AXE_WS,                    xi.evolith.suffix.DOUBLE_ATTACK,                      {   1,   1,   2,   3,   4,   5,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8 } },
    [171] = { xi.evolith.prefix.GREAT_AXE_WS,              xi.evolith.suffix.ACCURACY,                           {   1,   2,   4,   6,   8,  10,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [172] = { xi.evolith.prefix.GREAT_AXE_WS,              xi.evolith.suffix.TP_BONUS,                           {   2,   4,   6,   9,  12,  16,  20,  25,  25,  25,  25,  25,  25,  25,  25,  25 } },
    [173] = { xi.evolith.prefix.SCYTHE_WS,                 xi.evolith.suffix.ENMITY,                             { 255, 254, 253, 252, 251, 250, 248, 246, 246, 246, 246, 246, 246, 246, 246, 246 } },
    [174] = { xi.evolith.prefix.SCYTHE_WS,                 xi.evolith.suffix.SKILLCHAIN_DAMAGE,                  {   1,   2,   3,   4,   5,   6,   8,  10,  10,  10,  10,  10,  10,  10,  10,  10 } },
    [175] = { xi.evolith.prefix.POLEARM_WS,                xi.evolith.suffix.ACCURACY,                           {   1,   2,   4,   6,   8,  10,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [176] = { xi.evolith.prefix.POLEARM_WS,                xi.evolith.suffix.CRITICAL_HIT_RATE,                  {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [177] = { xi.evolith.prefix.KATANA_WS,                 xi.evolith.suffix.ENMITY,                             {   1,   2,   3,   4,   5,   6,   8,  10,  10,  10,  10,  10,  10,  10,  10,  10 } },
    [178] = { xi.evolith.prefix.KATANA_WS,                 xi.evolith.suffix.CRITICAL_HIT_RATE,                  {   1,   1,   2,   3,   4,   5,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8 } },
    [179] = { xi.evolith.prefix.GREAT_KATANA_WS,           xi.evolith.suffix.ACCURACY,                           {   1,   2,   4,   6,   8,  10,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [180] = { xi.evolith.prefix.GREAT_KATANA_WS,           xi.evolith.suffix.SKILLCHAIN_DAMAGE,                  {   1,   1,   2,   3,   4,   5,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8 } },
    [181] = { xi.evolith.prefix.CLUB_WS,                   xi.evolith.suffix.ATTACK,                             {   2,   4,   6,   9,  12,  16,  20,  25,  25,  25,  25,  25,  25,  25,  25,  25 } },
    [182] = { xi.evolith.prefix.CLUB_WS,                   xi.evolith.suffix.DOUBLE_ATTACK,                      {   1,   1,   2,   3,   4,   5,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8 } },
    [183] = { xi.evolith.prefix.STAFF_WS,                  xi.evolith.suffix.ENMITY,                             { 255, 254, 253, 252, 251, 250, 248, 246, 246, 246, 246, 246, 246, 246, 246, 246 } },
    [184] = { xi.evolith.prefix.STAFF_WS,                  xi.evolith.suffix.TP_BONUS,                           {   2,   4,   6,   9,  12,  16,  20,  25,  25,  25,  25,  25,  25,  25,  25,  25 } },
    [185] = { xi.evolith.prefix.ARCHERY_WS,                xi.evolith.suffix.RANGED_ACCURACY,                    {   1,   2,   4,   6,   8,  10,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [186] = { xi.evolith.prefix.ARCHERY_WS,                xi.evolith.suffix.TP_BONUS,                           {   2,   4,   6,   9,  12,  16,  20,  25,  25,  25,  25,  25,  25,  25,  25,  25 } },
    [187] = { xi.evolith.prefix.MARKSMANSHIP_WS,           xi.evolith.suffix.RANGED_ATTACK,                      {   1,   2,   4,   6,   8,  10,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [188] = { xi.evolith.prefix.MARKSMANSHIP_WS,           xi.evolith.suffix.SKILLCHAIN_DAMAGE,                  {   1,   2,   3,   4,   5,   6,   8,  10,  10,  10,  10,  10,  10,  10,  10,  10 } },
    [189] = { xi.evolith.prefix.DIVINE_MAGIC_LIGHT,        xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [190] = { xi.evolith.prefix.DIVINE_MAGIC_LIGHT,        xi.evolith.suffix.RECAST_DELAY,                       {   2,   2,   2,   3,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [191] = { xi.evolith.prefix.HEALING_MAGIC_LIGHT,       xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [192] = { xi.evolith.prefix.HEALING_MAGIC_LIGHT,       xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [193] = { xi.evolith.prefix.ENHANCING_MAGIC_FIRE,      xi.evolith.suffix.CONSERVE_MP,                        {   1,   1,   2,   3,   4,   5,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8 } },
    [194] = { xi.evolith.prefix.ENHANCING_MAGIC_FIRE,      xi.evolith.suffix.RECAST_DELAY,                       {   2,   2,   2,   3,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [195] = { xi.evolith.prefix.ENHANCING_MAGIC_ICE,       xi.evolith.suffix.CONSERVE_MP,                        {   1,   1,   2,   3,   4,   5,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8 } },
    [196] = { xi.evolith.prefix.ENHANCING_MAGIC_ICE,       xi.evolith.suffix.RECAST_DELAY,                       {   2,   2,   2,   3,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [197] = { xi.evolith.prefix.ENHANCING_MAGIC_WIND,      xi.evolith.suffix.CONSERVE_MP,                        {   1,   1,   2,   3,   4,   5,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8 } },
    [198] = { xi.evolith.prefix.ENHANCING_MAGIC_WIND,      xi.evolith.suffix.RECAST_DELAY,                       {   2,   2,   2,   3,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [199] = { xi.evolith.prefix.ENHANCING_MAGIC_EARTH,     xi.evolith.suffix.CONSERVE_MP,                        {   1,   1,   2,   3,   4,   5,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8 } },
    [200] = { xi.evolith.prefix.ENHANCING_MAGIC_EARTH,     xi.evolith.suffix.RECAST_DELAY,                       {   2,   2,   2,   3,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [201] = { xi.evolith.prefix.ENHANCING_MAGIC_LIGHTNING, xi.evolith.suffix.CONSERVE_MP,                        {   1,   1,   2,   3,   4,   5,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8 } },
    [202] = { xi.evolith.prefix.ENHANCING_MAGIC_LIGHTNING, xi.evolith.suffix.RECAST_DELAY,                       {   2,   2,   2,   3,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [203] = { xi.evolith.prefix.ENHANCING_MAGIC_WATER,     xi.evolith.suffix.CONSERVE_MP,                        {   1,   1,   2,   3,   4,   5,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8 } },
    [204] = { xi.evolith.prefix.ENHANCING_MAGIC_WATER,     xi.evolith.suffix.RECAST_DELAY,                       {   2,   2,   2,   3,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [205] = { xi.evolith.prefix.ENHANCING_MAGIC_LIGHT,     xi.evolith.suffix.CONSERVE_MP,                        {   1,   1,   2,   3,   4,   5,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8 } },
    [206] = { xi.evolith.prefix.ENHANCING_MAGIC_LIGHT,     xi.evolith.suffix.RECAST_DELAY,                       {   2,   2,   2,   3,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [207] = { xi.evolith.prefix.ENHANCING_MAGIC_DARK,      xi.evolith.suffix.CONSERVE_MP,                        {   1,   1,   2,   3,   4,   5,   6,   8,   8,   8,   8,   8,   8,   8,   8,   8 } },
    [208] = { xi.evolith.prefix.ENHANCING_MAGIC_DARK,      xi.evolith.suffix.RECAST_DELAY,                       {   2,   2,   2,   3,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [209] = { xi.evolith.prefix.ENFEEBLING_MAGIC_FIRE,     xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1 } },
    [210] = { xi.evolith.prefix.ENFEEBLING_MAGIC_FIRE,     xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1 } },
    [211] = { xi.evolith.prefix.ENFEEBLING_MAGIC_ICE,      xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [212] = { xi.evolith.prefix.ENFEEBLING_MAGIC_ICE,      xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [213] = { xi.evolith.prefix.ENFEEBLING_MAGIC_WIND,     xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [214] = { xi.evolith.prefix.ENFEEBLING_MAGIC_WIND,     xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [215] = { xi.evolith.prefix.ENFEEBLING_MAGIC_EARTH,    xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [216] = { xi.evolith.prefix.ENFEEBLING_MAGIC_EARTH,    xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [217] = { xi.evolith.prefix.ENFEEBLING_MAGIC_EARTH,    xi.evolith.suffix.NONE,                               {   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1 } },
    [218] = { xi.evolith.prefix.ENFEEBLING_MAGIC_EARTH,    xi.evolith.suffix.NONE,                               {   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1 } },
    [219] = { xi.evolith.prefix.ENFEEBLING_MAGIC_WATER,    xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [220] = { xi.evolith.prefix.ENFEEBLING_MAGIC_WATER,    xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [221] = { xi.evolith.prefix.ENFEEBLING_MAGIC_LIGHT,    xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [222] = { xi.evolith.prefix.ENFEEBLING_MAGIC_LIGHT,    xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [223] = { xi.evolith.prefix.ENFEEBLING_MAGIC_DARK,     xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [224] = { xi.evolith.prefix.ENFEEBLING_MAGIC_DARK,     xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [225] = { xi.evolith.prefix.ELEMENTAL_MAGIC_FIRE,      xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [226] = { xi.evolith.prefix.ELEMENTAL_MAGIC_FIRE,      xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE,            {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [227] = { xi.evolith.prefix.ELEMENTAL_MAGIC_ICE,       xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [228] = { xi.evolith.prefix.ELEMENTAL_MAGIC_ICE,       xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE,            {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [229] = { xi.evolith.prefix.ELEMENTAL_MAGIC_WIND,      xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [230] = { xi.evolith.prefix.ELEMENTAL_MAGIC_WIND,      xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE,            {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [231] = { xi.evolith.prefix.ELEMENTAL_MAGIC_EARTH,     xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [232] = { xi.evolith.prefix.ELEMENTAL_MAGIC_EARTH,     xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE,            {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [233] = { xi.evolith.prefix.ELEMENTAL_MAGIC_LIGHTNING, xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [234] = { xi.evolith.prefix.ELEMENTAL_MAGIC_LIGHTNING, xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE,            {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [235] = { xi.evolith.prefix.ELEMENTAL_MAGIC_WATER,     xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [236] = { xi.evolith.prefix.ELEMENTAL_MAGIC_WATER,     xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE,            {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [237] = { xi.evolith.prefix.ELEMENTAL_MAGIC_LIGHT,     xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [238] = { xi.evolith.prefix.ELEMENTAL_MAGIC_LIGHT,     xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE,            {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [239] = { xi.evolith.prefix.ELEMENTAL_MAGIC_DARK,      xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [240] = { xi.evolith.prefix.ELEMENTAL_MAGIC_DARK,      xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE,            {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [241] = { xi.evolith.prefix.DARK_MAGIC_DARK,           xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [242] = { xi.evolith.prefix.DARK_MAGIC_DARK,           xi.evolith.suffix.RECAST_DELAY,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [243] = { xi.evolith.prefix.SONGS_FIRE,                xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [244] = { xi.evolith.prefix.SONGS_FIRE,                xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [245] = { xi.evolith.prefix.SONGS_ICE,                 xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [246] = { xi.evolith.prefix.SONGS_ICE,                 xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [247] = { xi.evolith.prefix.SONGS_WIND,                xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [248] = { xi.evolith.prefix.SONGS_WIND,                xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [249] = { xi.evolith.prefix.SONGS_EARTH,               xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [250] = { xi.evolith.prefix.SONGS_EARTH,               xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [251] = { xi.evolith.prefix.SONGS_LIGHTNING,           xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [252] = { xi.evolith.prefix.SONGS_LIGHTNING,           xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [253] = { xi.evolith.prefix.SONGS_WATER,               xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [254] = { xi.evolith.prefix.SONGS_WATER,               xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [255] = { xi.evolith.prefix.SONGS_LIGHT,               xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [256] = { xi.evolith.prefix.SONGS_LIGHT,               xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [257] = { xi.evolith.prefix.SONGS_DARK,                xi.evolith.suffix.ENMITY,                             { 255, 255, 255, 254, 254, 253, 252, 250, 250, 250, 250, 250, 250, 250, 250, 250 } },
    [258] = { xi.evolith.prefix.SONGS_DARK,                xi.evolith.suffix.CASTING_TIME,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [259] = { xi.evolith.prefix.NINJUTSU_FIRE,             xi.evolith.suffix.ENMITY,                             {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [260] = { xi.evolith.prefix.NINJUTSU_FIRE,             xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [261] = { xi.evolith.prefix.NINJUTSU_ICE,              xi.evolith.suffix.ENMITY,                             {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [262] = { xi.evolith.prefix.NINJUTSU_ICE,              xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [263] = { xi.evolith.prefix.NINJUTSU_WIND,             xi.evolith.suffix.ENMITY,                             {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [264] = { xi.evolith.prefix.NINJUTSU_WIND,             xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [265] = { xi.evolith.prefix.NINJUTSU_EARTH,            xi.evolith.suffix.ENMITY,                             {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [266] = { xi.evolith.prefix.NINJUTSU_EARTH,            xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [267] = { xi.evolith.prefix.NINJUTSU_LIGHTNING,        xi.evolith.suffix.ENMITY,                             {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [268] = { xi.evolith.prefix.NINJUTSU_LIGHTNING,        xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [269] = { xi.evolith.prefix.NINJUTSU_WATER,            xi.evolith.suffix.ENMITY,                             {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [270] = { xi.evolith.prefix.NINJUTSU_WATER,            xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [271] = { xi.evolith.prefix.NINJUTSU_LIGHT,            xi.evolith.suffix.ENMITY,                             {   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1 } },
    [272] = { xi.evolith.prefix.NINJUTSU_LIGHT,            xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1 } },
    [273] = { xi.evolith.prefix.NINJUTSU_DARK,             xi.evolith.suffix.ENMITY,                             {   1,   1,   2,   2,   3,   4,   5,   7,   7,   7,   7,   7,   7,   7,   7,   7 } },
    [274] = { xi.evolith.prefix.NINJUTSU_DARK,             xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [275] = { xi.evolith.prefix.BLUE_MAGIC_FIRE,           xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [276] = { xi.evolith.prefix.BLUE_MAGIC_FIRE,           xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [277] = { xi.evolith.prefix.BLUE_MAGIC_ICE,            xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [278] = { xi.evolith.prefix.BLUE_MAGIC_ICE,            xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [279] = { xi.evolith.prefix.BLUE_MAGIC_WIND,           xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [280] = { xi.evolith.prefix.BLUE_MAGIC_WIND,           xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [281] = { xi.evolith.prefix.BLUE_MAGIC_EARTH,          xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [282] = { xi.evolith.prefix.BLUE_MAGIC_EARTH,          xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [283] = { xi.evolith.prefix.BLUE_MAGIC_LIGHTNING,      xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [284] = { xi.evolith.prefix.BLUE_MAGIC_LIGHTNING,      xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [285] = { xi.evolith.prefix.BLUE_MAGIC_WATER,          xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [286] = { xi.evolith.prefix.BLUE_MAGIC_WATER,          xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [287] = { xi.evolith.prefix.BLUE_MAGIC_LIGHT,          xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [288] = { xi.evolith.prefix.BLUE_MAGIC_LIGHT,          xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [289] = { xi.evolith.prefix.BLUE_MAGIC_DARK,           xi.evolith.suffix.MAGIC_ACCURACY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [290] = { xi.evolith.prefix.BLUE_MAGIC_DARK,           xi.evolith.suffix.MAGIC_ATTACK_BONUS,                 {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [291] = { xi.evolith.prefix.BLUE_MAGIC_PHYSICAL,       xi.evolith.suffix.ATTACK,                             {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [292] = { xi.evolith.prefix.BLUE_MAGIC_PHYSICAL,       xi.evolith.suffix.ACCURACY,                           {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [293] = { xi.evolith.prefix.WEATHER_FIRE,              xi.evolith.suffix.ADDITIONAL_EFFECT_DISEASE,          {   1,   1,   2,   3,   4,   6,   8,  10,  10,  10,  10,  10,  10,  10,  10,  10 } },
    [294] = { xi.evolith.prefix.WEATHER_ICE,               xi.evolith.suffix.ADDITIONAL_EFFECT_PARALYSIS,        {   1,   1,   2,   3,   4,   6,   8,  10,  10,  10,  10,  10,  10,  10,  10,  10 } },
    [295] = { xi.evolith.prefix.WEATHER_WIND,              xi.evolith.suffix.ADDITIONAL_EFFECT_SILENCE,          {   1,   1,   2,   3,   4,   6,   8,  10,  10,  10,  10,  10,  10,  10,  10,  10 } },
    [296] = { xi.evolith.prefix.WEATHER_EARTH,             xi.evolith.suffix.ADDITIONAL_EFFECT_SLOW,             {   1,   1,   2,   3,   4,   6,   8,  10,  10,  10,  10,  10,  10,  10,  10,  10 } },
    [297] = { xi.evolith.prefix.WEATHER_LIGHTNING,         xi.evolith.suffix.ADDITIONAL_EFFECT_STUN,             {   1,   1,   1,   2,   2,   3,   4,   5,   5,   5,   5,   5,   5,   5,   5,   5 } },
    [298] = { xi.evolith.prefix.WEATHER_WATER,             xi.evolith.suffix.ADDITIONAL_EFFECT_POISON,           {   1,   1,   1,   2,   2,   3,   4,   5,   5,   5,   5,   5,   5,   5,   5,   5 } },
    [299] = { xi.evolith.prefix.WEATHER_LIGHT,             xi.evolith.suffix.ADDITIONAL_EFFECT_DEFENSE_DOWN,     {   3,   4,   5,   6,   7,   8,  10,  12,  12,  12,  12,  12,  12,  12,  12,  12 } },
    [300] = { xi.evolith.prefix.WEATHER_DARK,              xi.evolith.suffix.ADDITIONAL_EFFECT_SLEEP,            {   1,   1,   2,   3,   4,   6,   8,  10,  10,  10,  10,  10,  10,  10,  10,  10 } },
    [301] = { xi.evolith.prefix.WEATHER_FIRE,              xi.evolith.suffix.ADDITIONAL_EFFECT_FIRE_DAMAGE,      {   1,   1,   2,   4,   6,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [302] = { xi.evolith.prefix.WEATHER_ICE,               xi.evolith.suffix.ADDITIONAL_EFFECT_ICE_DAMAGE,       {   1,   1,   2,   4,   6,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [303] = { xi.evolith.prefix.WEATHER_WIND,              xi.evolith.suffix.ADDITIONAL_EFFECT_WIND_DAMAGE,      {   1,   1,   2,   4,   6,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [304] = { xi.evolith.prefix.WEATHER_EARTH,             xi.evolith.suffix.ADDITIONAL_EFFECT_EARTH_DAMAGE,     {   1,   1,   2,   4,   6,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [305] = { xi.evolith.prefix.WEATHER_LIGHTNING,         xi.evolith.suffix.ADDITIONAL_EFFECT_LIGHTNING_DAMAGE, {   1,   1,   2,   4,   6,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [306] = { xi.evolith.prefix.WEATHER_WATER,             xi.evolith.suffix.ADDITIONAL_EFFECT_WATER_DAMAGE,     {   1,   1,   2,   4,   6,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [307] = { xi.evolith.prefix.WEATHER_LIGHT,             xi.evolith.suffix.ADDITIONAL_EFFECT_LIGHT_DAMAGE,     {   1,   1,   2,   4,   6,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [308] = { xi.evolith.prefix.WEATHER_DARK,              xi.evolith.suffix.ADDITIONAL_EFFECT_DARK_DAMAGE,      {   1,   1,   2,   4,   6,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [309] = { xi.evolith.prefix.NONE,                      xi.evolith.suffix.HP,                                 {   2,   4,   6,   9,  12,  16,  20,  25,  25,  25,  25,  25,  25,  25,  25,  25 } },
    [310] = { xi.evolith.prefix.NONE,                      xi.evolith.suffix.MP,                                 {   2,   4,   6,   8,  11,  14,  17,  20,  20,  20,  20,  20,  20,  20,  20,  20 } },
    [311] = { xi.evolith.prefix.NONE,                      xi.evolith.suffix.RESIST_VIRUS,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [312] = { xi.evolith.prefix.NONE,                      xi.evolith.suffix.RESIST_SLOW,                        {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [313] = { xi.evolith.prefix.NONE,                      xi.evolith.suffix.RESIST_SILENCE,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [314] = { xi.evolith.prefix.NONE,                      xi.evolith.suffix.RESIST_PARALYZE,                    {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [315] = { xi.evolith.prefix.NONE,                      xi.evolith.suffix.RESIST_GRAVITY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [316] = { xi.evolith.prefix.NONE,                      xi.evolith.suffix.RESIST_PETRIFY,                     {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [317] = { xi.evolith.prefix.NONE,                      xi.evolith.suffix.RESIST_SLEEP,                       {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [318] = { xi.evolith.prefix.NONE,                      xi.evolith.suffix.RESIST_POISON,                      {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [319] = { xi.evolith.prefix.NONE,                      xi.evolith.suffix.RESIST_BIND,                        {   1,   1,   1,   2,   2,   3,   4,   6,   6,   6,   6,   6,   6,   6,   6,   6 } },
    [320] = { xi.evolith.prefix.SKILLCHAIN_LIGHT,          xi.evolith.suffix.SKILLCHAIN_DAMAGE,                  {   1,   1,   2,   3,   4,   6,   8,  10,  10,  10,  10,  10,  10,  10,  10,  10 } },
    [321] = { xi.evolith.prefix.SKILLCHAIN_DARK,           xi.evolith.suffix.SKILLCHAIN_DAMAGE,                  {   1,   1,   2,   3,   4,   6,   8,  10,  10,  10,  10,  10,  10,  10,  10,  10 } },
    [322] = { xi.evolith.prefix.SKILLCHAIN_LIGHT,          xi.evolith.suffix.SKILLCHAIN_ACCURACY,                {   1,   1,   2,   4,   6,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [323] = { xi.evolith.prefix.SKILLCHAIN_DARK,           xi.evolith.suffix.SKILLCHAIN_ACCURACY,                {   1,   1,   2,   4,   6,   9,  12,  15,  15,  15,  15,  15,  15,  15,  15,  15 } },
    [324] = { xi.evolith.prefix.SKILLCHAIN_LIGHT,          xi.evolith.suffix.MAGIC_BURST_DAMAGE,                 {   1,   1,   2,   3,   4,   6,   8,  10,  10,  10,  10,  10,  10,  10,  10,  10 } },
    [325] = { xi.evolith.prefix.SKILLCHAIN_DARK,           xi.evolith.suffix.MAGIC_BURST_DAMAGE,                 {   1,   1,   2,   3,   4,   6,   8,  10,  10,  10,  10,  10,  10,  10,  10,  10 } },
}

-- Table used to look up the Evolith augment ID to assign to an Evolith at rewards time
---@type table<xi.evolith.prefix, table<xi.evolith.suffix, integer>>
xi.data.augments.evolithIndex =
{
    [xi.evolith.prefix.VS_BEASTS] =
    {
        [xi.evolith.suffix.ATTACK             ] =  1,
        [xi.evolith.suffix.DEFENSE            ] =  2,
        [xi.evolith.suffix.ACCURACY           ] =  3,
        [xi.evolith.suffix.EVASION            ] =  4,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] =  5,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] =  6,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] =  7,
        [xi.evolith.suffix.MAGIC_EVASION      ] =  8,
        [xi.evolith.suffix.RANGED_ATTACK      ] =  9,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 10,
    },

    [xi.evolith.prefix.VS_PLANTOIDS] =
    {
        [xi.evolith.suffix.ATTACK             ] = 11,
        [xi.evolith.suffix.DEFENSE            ] = 12,
        [xi.evolith.suffix.ACCURACY           ] = 13,
        [xi.evolith.suffix.EVASION            ] = 14,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] = 15,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] = 16,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] = 17,
        [xi.evolith.suffix.MAGIC_EVASION      ] = 18,
        [xi.evolith.suffix.RANGED_ATTACK      ] = 19,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 20,
    },

    [xi.evolith.prefix.VS_VERMIN] =
    {
        [xi.evolith.suffix.ATTACK             ] = 21,
        [xi.evolith.suffix.DEFENSE            ] = 22,
        [xi.evolith.suffix.ACCURACY           ] = 23,
        [xi.evolith.suffix.EVASION            ] = 24,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] = 25,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] = 26,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] = 27,
        [xi.evolith.suffix.MAGIC_EVASION      ] = 28,
        [xi.evolith.suffix.RANGED_ATTACK      ] = 29,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 30,
    },

    [xi.evolith.prefix.VS_LIZARDS] =
    {
        [xi.evolith.suffix.ATTACK             ] = 31,
        [xi.evolith.suffix.DEFENSE            ] = 32,
        [xi.evolith.suffix.ACCURACY           ] = 33,
        [xi.evolith.suffix.EVASION            ] = 34,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] = 35,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] = 36,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] = 37,
        [xi.evolith.suffix.MAGIC_EVASION      ] = 38,
        [xi.evolith.suffix.RANGED_ATTACK      ] = 39,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 40,
    },

    [xi.evolith.prefix.VS_BIRDS] =
    {
        [xi.evolith.suffix.ATTACK             ] = 41,
        [xi.evolith.suffix.DEFENSE            ] = 42,
        [xi.evolith.suffix.ACCURACY           ] = 43,
        [xi.evolith.suffix.EVASION            ] = 44,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] = 45,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] = 46,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] = 47,
        [xi.evolith.suffix.MAGIC_EVASION      ] = 48,
        [xi.evolith.suffix.RANGED_ATTACK      ] = 49,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 50,
    },

    [xi.evolith.prefix.VS_AMORPHS] =
    {
        [xi.evolith.suffix.ATTACK             ] = 51,
        [xi.evolith.suffix.DEFENSE            ] = 52,
        [xi.evolith.suffix.ACCURACY           ] = 53,
        [xi.evolith.suffix.EVASION            ] = 54,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] = 55,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] = 56,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] = 57,
        [xi.evolith.suffix.MAGIC_EVASION      ] = 58,
        [xi.evolith.suffix.RANGED_ATTACK      ] = 59,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 60,
    },

    [xi.evolith.prefix.VS_AQUANS] =
    {
        [xi.evolith.suffix.ATTACK             ] = 61,
        [xi.evolith.suffix.DEFENSE            ] = 62,
        [xi.evolith.suffix.ACCURACY           ] = 63,
        [xi.evolith.suffix.EVASION            ] = 64,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] = 65,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] = 66,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] = 67,
        [xi.evolith.suffix.MAGIC_EVASION      ] = 68,
        [xi.evolith.suffix.RANGED_ATTACK      ] = 69,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 70,
    },

    [xi.evolith.prefix.VS_UNDEAD] =
    {
        [xi.evolith.suffix.ATTACK             ] = 71,
        [xi.evolith.suffix.DEFENSE            ] = 72,
        [xi.evolith.suffix.ACCURACY           ] = 73,
        [xi.evolith.suffix.EVASION            ] = 74,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] = 75,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] = 76,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] = 77,
        [xi.evolith.suffix.MAGIC_EVASION      ] = 78,
        [xi.evolith.suffix.RANGED_ATTACK      ] = 79,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 80,
    },

    [xi.evolith.prefix.VS_ELEMENTALS] =
    {
        [xi.evolith.suffix.ATTACK             ] = 81,
        [xi.evolith.suffix.DEFENSE            ] = 82,
        [xi.evolith.suffix.ACCURACY           ] = 83,
        [xi.evolith.suffix.EVASION            ] = 84,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] = 85,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] = 86,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] = 87,
        [xi.evolith.suffix.MAGIC_EVASION      ] = 88,
        [xi.evolith.suffix.RANGED_ATTACK      ] = 89,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 90,
    },

    [xi.evolith.prefix.VS_ARCANA] =
    {
        [xi.evolith.suffix.ATTACK             ] =  91,
        [xi.evolith.suffix.DEFENSE            ] =  92,
        [xi.evolith.suffix.ACCURACY           ] =  93,
        [xi.evolith.suffix.EVASION            ] =  94,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] =  95,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] =  96,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] =  97,
        [xi.evolith.suffix.MAGIC_EVASION      ] =  98,
        [xi.evolith.suffix.RANGED_ATTACK      ] =  99,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 100,
    },

    [xi.evolith.prefix.VS_DEMONS] =
    {
        [xi.evolith.suffix.ATTACK             ] = 101,
        [xi.evolith.suffix.DEFENSE            ] = 102,
        [xi.evolith.suffix.ACCURACY           ] = 103,
        [xi.evolith.suffix.EVASION            ] = 104,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] = 105,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] = 106,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] = 107,
        [xi.evolith.suffix.MAGIC_EVASION      ] = 108,
        [xi.evolith.suffix.RANGED_ATTACK      ] = 109,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 110,
    },

    [xi.evolith.prefix.VS_DRAGONS] =
    {
        [xi.evolith.suffix.ATTACK             ] = 111,
        [xi.evolith.suffix.DEFENSE            ] = 112,
        [xi.evolith.suffix.ACCURACY           ] = 113,
        [xi.evolith.suffix.EVASION            ] = 114,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] = 115,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] = 116,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] = 117,
        [xi.evolith.suffix.MAGIC_EVASION      ] = 118,
        [xi.evolith.suffix.RANGED_ATTACK      ] = 119,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 120,
    },

    [xi.evolith.prefix.VS_EMPTY] =
    {
        [xi.evolith.suffix.ATTACK             ] = 121,
        [xi.evolith.suffix.DEFENSE            ] = 122,
        [xi.evolith.suffix.ACCURACY           ] = 123,
        [xi.evolith.suffix.EVASION            ] = 124,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] = 125,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] = 126,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] = 127,
        [xi.evolith.suffix.MAGIC_EVASION      ] = 128,
        [xi.evolith.suffix.RANGED_ATTACK      ] = 129,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 130,
    },

    [xi.evolith.prefix.VS_LUMINIANS] =
    {
        [xi.evolith.suffix.ATTACK             ] = 131,
        [xi.evolith.suffix.DEFENSE            ] = 132,
        [xi.evolith.suffix.ACCURACY           ] = 133,
        [xi.evolith.suffix.EVASION            ] = 134,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS ] = 135,
        [xi.evolith.suffix.MAGIC_DEFENSE_BONUS] = 136,
        [xi.evolith.suffix.MAGIC_ACCURACY     ] = 137,
        [xi.evolith.suffix.MAGIC_EVASION      ] = 138,
        [xi.evolith.suffix.RANGED_ATTACK      ] = 139,
        [xi.evolith.suffix.RANGED_ACCURACY    ] = 140,
    },

    [xi.evolith.prefix.MIGHTY_STRIKES] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 141,
    },

    [xi.evolith.prefix.HUNDRED_FISTS] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 142,
    },

    [xi.evolith.prefix.BENEDICTION] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 143,
    },

    [xi.evolith.prefix.MANAFONT] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 144,
    },

    [xi.evolith.prefix.CHAINSPELL] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 145,
    },

    [xi.evolith.prefix.PERFECT_DODGE] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 146,
    },

    [xi.evolith.prefix.INVINCIBLE] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 147,
    },

    [xi.evolith.prefix.BLOOD_WEAPON] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 148,
    },

    [xi.evolith.prefix.FAMILIAR] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 149,
    },

    [xi.evolith.prefix.SOUL_VOICE] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 150,
    },

    [xi.evolith.prefix.EAGLE_EYE_SHOT] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 151,
    },

    [xi.evolith.prefix.MEIKYO_SHISUI] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 152,
    },

    [xi.evolith.prefix.MIJIN_GAKURE] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 153,
    },

    [xi.evolith.prefix.SPIRIT_SURGE] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 154,
    },

    [xi.evolith.prefix.ASTRAL_FLOW] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 155,
    },

    [xi.evolith.prefix.AZURE_LORE] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 156,
    },

    [xi.evolith.prefix.WILD_CARD] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 157,
    },

    [xi.evolith.prefix.OVERDRIVE] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 158,
    },

    [xi.evolith.prefix.TRANCE] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 159,
    },

    [xi.evolith.prefix.TABULA_RASA] =
    {
        [xi.evolith.suffix.ABILITY_DELAY] = 160,
    },

    [xi.evolith.prefix.HAND_TO_HAND_WS] =
    {
        [xi.evolith.suffix.ENMITY  ] = 161,
        [xi.evolith.suffix.TP_BONUS] = 162,
    },

    [xi.evolith.prefix.DAGGER_WS] =
    {
        [xi.evolith.suffix.ATTACK       ] = 163,
        [xi.evolith.suffix.TRIPLE_ATTACK] = 164,
    },

    [xi.evolith.prefix.SWORD_WS] =
    {
        [xi.evolith.suffix.ATTACK           ] = 165,
        [xi.evolith.suffix.CRITICAL_HIT_RATE] = 166,
    },

    [xi.evolith.prefix.GREAT_SWORD_WS] =
    {
        [xi.evolith.suffix.ACCURACY     ] = 167,
        [xi.evolith.suffix.DOUBLE_ATTACK] = 168,
    },

    [xi.evolith.prefix.AXE_WS] =
    {
        [xi.evolith.suffix.ATTACK       ] = 169,
        [xi.evolith.suffix.DOUBLE_ATTACK] = 170,
    },

    [xi.evolith.prefix.GREAT_AXE_WS] =
    {
        [xi.evolith.suffix.ACCURACY] = 171,
        [xi.evolith.suffix.TP_BONUS] = 172,
    },

    [xi.evolith.prefix.SCYTHE_WS] =
    {
        [xi.evolith.suffix.ENMITY           ] = 173,
        [xi.evolith.suffix.SKILLCHAIN_DAMAGE] = 174,
    },

    [xi.evolith.prefix.POLEARM_WS] =
    {
        [xi.evolith.suffix.ACCURACY         ] = 175,
        [xi.evolith.suffix.CRITICAL_HIT_RATE] = 176,
    },

    [xi.evolith.prefix.KATANA_WS] =
    {
        [xi.evolith.suffix.ENMITY           ] = 177,
        [xi.evolith.suffix.CRITICAL_HIT_RATE] = 178,
    },

    [xi.evolith.prefix.GREAT_KATANA_WS] =
    {
        [xi.evolith.suffix.ACCURACY         ] = 179,
        [xi.evolith.suffix.SKILLCHAIN_DAMAGE] = 180,
    },

    [xi.evolith.prefix.CLUB_WS] =
    {
        [xi.evolith.suffix.ATTACK       ] = 181,
        [xi.evolith.suffix.DOUBLE_ATTACK] = 182,
    },

    [xi.evolith.prefix.STAFF_WS] =
    {
        [xi.evolith.suffix.ENMITY  ] = 183,
        [xi.evolith.suffix.TP_BONUS] = 184,
    },

    [xi.evolith.prefix.ARCHERY_WS] =
    {
        [xi.evolith.suffix.RANGED_ACCURACY] = 185,
        [xi.evolith.suffix.TP_BONUS       ] = 186,
    },

    [xi.evolith.prefix.MARKSMANSHIP_WS] =
    {
        [xi.evolith.suffix.RANGED_ATTACK    ] = 187,
        [xi.evolith.suffix.SKILLCHAIN_DAMAGE] = 188,
    },

    [xi.evolith.prefix.DIVINE_MAGIC_LIGHT] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY] = 189,
        [xi.evolith.suffix.RECAST_DELAY  ] = 190,
    },

    [xi.evolith.prefix.HEALING_MAGIC_LIGHT] =
    {
        [xi.evolith.suffix.ENMITY      ] = 191,
        [xi.evolith.suffix.CASTING_TIME] = 192,
    },

    [xi.evolith.prefix.ENHANCING_MAGIC_FIRE] =
    {
        [xi.evolith.suffix.CONSERVE_MP ] = 193,
        [xi.evolith.suffix.RECAST_DELAY] = 194,
    },

    [xi.evolith.prefix.ENHANCING_MAGIC_ICE] =
    {
        [xi.evolith.suffix.CONSERVE_MP ] = 195,
        [xi.evolith.suffix.RECAST_DELAY] = 196,
    },

    [xi.evolith.prefix.ENHANCING_MAGIC_WIND] =
    {
        [xi.evolith.suffix.CONSERVE_MP ] = 197,
        [xi.evolith.suffix.RECAST_DELAY] = 198,
    },

    [xi.evolith.prefix.ENHANCING_MAGIC_EARTH] =
    {
        [xi.evolith.suffix.CONSERVE_MP ] = 199,
        [xi.evolith.suffix.RECAST_DELAY] = 200,
    },

    [xi.evolith.prefix.ENHANCING_MAGIC_LIGHTNING] =
    {
        [xi.evolith.suffix.CONSERVE_MP ] = 201,
        [xi.evolith.suffix.RECAST_DELAY] = 202,
    },

    [xi.evolith.prefix.ENHANCING_MAGIC_WATER] =
    {
        [xi.evolith.suffix.CONSERVE_MP ] = 203,
        [xi.evolith.suffix.RECAST_DELAY] = 204,
    },

    [xi.evolith.prefix.ENHANCING_MAGIC_LIGHT] =
    {
        [xi.evolith.suffix.CONSERVE_MP ] = 205,
        [xi.evolith.suffix.RECAST_DELAY] = 206,
    },

    [xi.evolith.prefix.ENHANCING_MAGIC_DARK] =
    {
        [xi.evolith.suffix.CONSERVE_MP ] = 207,
        [xi.evolith.suffix.RECAST_DELAY] = 208,
    },

    [xi.evolith.prefix.ENFEEBLING_MAGIC_FIRE] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY] = 209,
        [xi.evolith.suffix.CASTING_TIME  ] = 210,
    },

    [xi.evolith.prefix.ENFEEBLING_MAGIC_ICE] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY] = 211,
        [xi.evolith.suffix.CASTING_TIME  ] = 212,
    },

    [xi.evolith.prefix.ENFEEBLING_MAGIC_WIND] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY] = 213,
        [xi.evolith.suffix.CASTING_TIME  ] = 214,
    },

    [xi.evolith.prefix.ENFEEBLING_MAGIC_EARTH] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY] = 215,
        [xi.evolith.suffix.CASTING_TIME  ] = 216,
        [xi.evolith.suffix.NONE          ] = 217,
        [xi.evolith.suffix.NONE          ] = 218,
    },

    [xi.evolith.prefix.ENFEEBLING_MAGIC_WATER] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY] = 219,
        [xi.evolith.suffix.CASTING_TIME  ] = 220,
    },

    [xi.evolith.prefix.ENFEEBLING_MAGIC_LIGHT] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY] = 221,
        [xi.evolith.suffix.CASTING_TIME  ] = 222,
    },

    [xi.evolith.prefix.ENFEEBLING_MAGIC_DARK] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY] = 223,
        [xi.evolith.suffix.CASTING_TIME  ] = 224,
    },

    [xi.evolith.prefix.ELEMENTAL_MAGIC_FIRE] =
    {
        [xi.evolith.suffix.ENMITY                 ] = 225,
        [xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE] = 226,
    },

    [xi.evolith.prefix.ELEMENTAL_MAGIC_ICE] =
    {
        [xi.evolith.suffix.ENMITY                 ] = 227,
        [xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE] = 228,
    },

    [xi.evolith.prefix.ELEMENTAL_MAGIC_WIND] =
    {
        [xi.evolith.suffix.ENMITY                 ] = 229,
        [xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE] = 230,
    },

    [xi.evolith.prefix.ELEMENTAL_MAGIC_EARTH] =
    {
        [xi.evolith.suffix.ENMITY                 ] = 231,
        [xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE] = 232,
    },

    [xi.evolith.prefix.ELEMENTAL_MAGIC_LIGHTNING] =
    {
        [xi.evolith.suffix.ENMITY                 ] = 233,
        [xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE] = 234,
    },

    [xi.evolith.prefix.ELEMENTAL_MAGIC_WATER] =
    {
        [xi.evolith.suffix.ENMITY                 ] = 235,
        [xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE] = 236,
    },

    [xi.evolith.prefix.ELEMENTAL_MAGIC_LIGHT] =
    {
        [xi.evolith.suffix.ENMITY                 ] = 237,
        [xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE] = 238,
    },

    [xi.evolith.prefix.ELEMENTAL_MAGIC_DARK] =
    {
        [xi.evolith.suffix.ENMITY                 ] = 239,
        [xi.evolith.suffix.MAGIC_CRITICAL_HIT_RATE] = 240,
    },

    [xi.evolith.prefix.DARK_MAGIC_DARK] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY] = 241,
        [xi.evolith.suffix.RECAST_DELAY  ] = 242,
    },

    [xi.evolith.prefix.SONGS_FIRE] =
    {
        [xi.evolith.suffix.ENMITY      ] = 243,
        [xi.evolith.suffix.CASTING_TIME] = 244,
    },

    [xi.evolith.prefix.SONGS_ICE] =
    {
        [xi.evolith.suffix.ENMITY      ] = 245,
        [xi.evolith.suffix.CASTING_TIME] = 246,
    },

    [xi.evolith.prefix.SONGS_WIND] =
    {
        [xi.evolith.suffix.ENMITY      ] = 247,
        [xi.evolith.suffix.CASTING_TIME] = 248,
    },

    [xi.evolith.prefix.SONGS_EARTH] =
    {
        [xi.evolith.suffix.ENMITY      ] = 249,
        [xi.evolith.suffix.CASTING_TIME] = 250,
    },

    [xi.evolith.prefix.SONGS_LIGHTNING] =
    {
        [xi.evolith.suffix.ENMITY      ] = 251,
        [xi.evolith.suffix.CASTING_TIME] = 252,
    },

    [xi.evolith.prefix.SONGS_WATER] =
    {
        [xi.evolith.suffix.ENMITY      ] = 253,
        [xi.evolith.suffix.CASTING_TIME] = 254,
    },

    [xi.evolith.prefix.SONGS_LIGHT] =
    {
        [xi.evolith.suffix.ENMITY      ] = 255,
        [xi.evolith.suffix.CASTING_TIME] = 256,
    },

    [xi.evolith.prefix.SONGS_DARK] =
    {
        [xi.evolith.suffix.ENMITY      ] = 257,
        [xi.evolith.suffix.CASTING_TIME] = 258,
    },

    [xi.evolith.prefix.NINJUTSU_FIRE] =
    {
        [xi.evolith.suffix.ENMITY        ] = 259,
        [xi.evolith.suffix.MAGIC_ACCURACY] = 260,
    },

    [xi.evolith.prefix.NINJUTSU_ICE] =
    {
        [xi.evolith.suffix.ENMITY        ] = 261,
        [xi.evolith.suffix.MAGIC_ACCURACY] = 262,
    },

    [xi.evolith.prefix.NINJUTSU_WIND] =
    {
        [xi.evolith.suffix.ENMITY        ] = 263,
        [xi.evolith.suffix.MAGIC_ACCURACY] = 264,
    },

    [xi.evolith.prefix.NINJUTSU_EARTH] =
    {
        [xi.evolith.suffix.ENMITY        ] = 265,
        [xi.evolith.suffix.MAGIC_ACCURACY] = 266,
    },

    [xi.evolith.prefix.NINJUTSU_LIGHTNING] =
    {
        [xi.evolith.suffix.ENMITY        ] = 267,
        [xi.evolith.suffix.MAGIC_ACCURACY] = 268,
    },

    [xi.evolith.prefix.NINJUTSU_WATER] =
    {
        [xi.evolith.suffix.ENMITY        ] = 269,
        [xi.evolith.suffix.MAGIC_ACCURACY] = 270,
    },

    [xi.evolith.prefix.NINJUTSU_LIGHT] =
    {
        [xi.evolith.suffix.ENMITY        ] = 271,
        [xi.evolith.suffix.MAGIC_ACCURACY] = 272,
    },

    [xi.evolith.prefix.NINJUTSU_DARK] =
    {
        [xi.evolith.suffix.ENMITY        ] = 273,
        [xi.evolith.suffix.MAGIC_ACCURACY] = 274,
    },

    [xi.evolith.prefix.BLUE_MAGIC_FIRE] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY    ] = 275,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS] = 276,
    },

    [xi.evolith.prefix.BLUE_MAGIC_ICE] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY    ] = 277,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS] = 278,
    },

    [xi.evolith.prefix.BLUE_MAGIC_WIND] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY    ] = 279,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS] = 280,
    },

    [xi.evolith.prefix.BLUE_MAGIC_EARTH] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY    ] = 281,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS] = 282,
    },

    [xi.evolith.prefix.BLUE_MAGIC_LIGHTNING] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY    ] = 283,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS] = 284,
    },

    [xi.evolith.prefix.BLUE_MAGIC_WATER] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY    ] = 285,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS] = 286,
    },

    [xi.evolith.prefix.BLUE_MAGIC_LIGHT] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY    ] = 287,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS] = 288,
    },

    [xi.evolith.prefix.BLUE_MAGIC_DARK] =
    {
        [xi.evolith.suffix.MAGIC_ACCURACY    ] = 289,
        [xi.evolith.suffix.MAGIC_ATTACK_BONUS] = 290,
    },

    [xi.evolith.prefix.BLUE_MAGIC_PHYSICAL] =
    {
        [xi.evolith.suffix.ATTACK  ] = 291,
        [xi.evolith.suffix.ACCURACY] = 292,
    },

    [xi.evolith.prefix.WEATHER_FIRE] =
    {
        [xi.evolith.suffix.ADDITIONAL_EFFECT_DISEASE    ] = 293,
        [xi.evolith.suffix.ADDITIONAL_EFFECT_FIRE_DAMAGE] = 301,
    },

    [xi.evolith.prefix.WEATHER_ICE] =
    {
        [xi.evolith.suffix.ADDITIONAL_EFFECT_PARALYSIS ] = 294,
        [xi.evolith.suffix.ADDITIONAL_EFFECT_ICE_DAMAGE] = 302,
    },

    [xi.evolith.prefix.WEATHER_WIND] =
    {
        [xi.evolith.suffix.ADDITIONAL_EFFECT_SILENCE    ] = 295,
        [xi.evolith.suffix.ADDITIONAL_EFFECT_WIND_DAMAGE] = 303,
    },

    [xi.evolith.prefix.WEATHER_EARTH] =
    {
        [xi.evolith.suffix.ADDITIONAL_EFFECT_SLOW        ] = 296,
        [xi.evolith.suffix.ADDITIONAL_EFFECT_EARTH_DAMAGE] = 304,
    },

    [xi.evolith.prefix.WEATHER_LIGHTNING] =
    {
        [xi.evolith.suffix.ADDITIONAL_EFFECT_STUN            ] = 297,
        [xi.evolith.suffix.ADDITIONAL_EFFECT_LIGHTNING_DAMAGE] = 305,
    },

    [xi.evolith.prefix.WEATHER_WATER] =
    {
        [xi.evolith.suffix.ADDITIONAL_EFFECT_POISON      ] = 298,
        [xi.evolith.suffix.ADDITIONAL_EFFECT_WATER_DAMAGE] = 306,
    },

    [xi.evolith.prefix.WEATHER_LIGHT] =
    {
        [xi.evolith.suffix.ADDITIONAL_EFFECT_DEFENSE_DOWN] = 299,
        [xi.evolith.suffix.ADDITIONAL_EFFECT_LIGHT_DAMAGE] = 307,
    },

    [xi.evolith.prefix.WEATHER_DARK] =
    {
        [xi.evolith.suffix.ADDITIONAL_EFFECT_SLEEP      ] = 300,
        [xi.evolith.suffix.ADDITIONAL_EFFECT_DARK_DAMAGE] = 308,
    },

    [xi.evolith.prefix.NONE] =
    {
        [xi.evolith.suffix.HP             ] = 309,
        [xi.evolith.suffix.MP             ] = 310,
        [xi.evolith.suffix.RESIST_VIRUS   ] = 311,
        [xi.evolith.suffix.RESIST_SLOW    ] = 312,
        [xi.evolith.suffix.RESIST_SILENCE ] = 313,
        [xi.evolith.suffix.RESIST_PARALYZE] = 314,
        [xi.evolith.suffix.RESIST_GRAVITY ] = 315,
        [xi.evolith.suffix.RESIST_PETRIFY ] = 316,
        [xi.evolith.suffix.RESIST_SLEEP   ] = 317,
        [xi.evolith.suffix.RESIST_POISON  ] = 318,
        [xi.evolith.suffix.RESIST_BIND    ] = 319,
    },

    [xi.evolith.prefix.SKILLCHAIN_LIGHT] =
    {
        [xi.evolith.suffix.SKILLCHAIN_DAMAGE  ] = 320,
        [xi.evolith.suffix.SKILLCHAIN_ACCURACY] = 322,
        [xi.evolith.suffix.MAGIC_BURST_DAMAGE ] = 324,
    },

    [xi.evolith.prefix.SKILLCHAIN_DARK] =
    {
        [xi.evolith.suffix.SKILLCHAIN_DAMAGE  ] = 321,
        [xi.evolith.suffix.SKILLCHAIN_ACCURACY] = 323,
        [xi.evolith.suffix.MAGIC_BURST_DAMAGE ] = 325,
    },
}

-- Bundle-type augments: Dynamis-D, Odyssey, Oboro
-- Source: Parsed from MNC2 data and client decomp
--   Augment index N has up to 6 slots read as uint16 at file offset 176 + 2 * (N * 6 + slot).
--   Each slot value is a record index; records are 76 bytes each starting at file offset 12464.
-- Usage:
--   Item exdata stores a single augment "bundle" ID
--   Bundle ID maps to several effects
--   First column is the DAT effect ID that will need to be mapped to a mod
--   Second column is the effect value for each rank (up to 30) - Not all items make use of all 30 ranks.
--   Note: Certain effects contain multiple parameters.
--       They can represent:
--         - A prefix denoting the entity on which the subsequent effect applies
--         - A bitmask representing which "sub-effects" are selected from a pooled effect (i.e. Acc and R.Acc but not Magic Acc)
--         - A weaponskill for which the DMG mod applies
xi.data.augments.bundles =
{
    [1] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [2] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [3] =
    {
        -- HP+#
        { { 9 },    { 0, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 140, 160, 180, 200, 220, 240, 260, 280, 300, 320, 340, 360, 380, 400, 400, 400, 400, 400, 400 } },
        -- "Chakra"+#
        { { 1600 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 50, 50, 50, 50, 50 } },
    },
    [4] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [5] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [6] =
    {
        -- HP+#
        { { 9 },    { 0, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 140, 160, 180, 200, 220, 240, 260, 280, 300, 320, 340, 360, 380, 400, 400, 400, 400, 400, 400 } },
        -- "Chakra"+#
        { { 1600 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 50, 50, 50, 50, 50 } },
    },
    [7] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12 } },
    },
    [8] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12 } },
    },
    [9] =
    {
        -- HP+#
        { { 9 },    { 0, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 140, 160, 180, 200, 220, 240, 260, 280, 300, 320, 340, 360, 380, 400, 400, 400, 400, 400, 400 } },
        -- "Chakra"+#
        { { 1600 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 50, 50, 50, 50, 50 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12 } },
    },
    [10] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [11] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [12] =
    {
        -- Weapon skill damage +#%
        { { 327 },                                   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Automaton:Special attack damage+#%
        { { xi.augment.parametric.AUTOMATON, 1314 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [13] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [14] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [15] =
    {
        -- Weapon skill damage +#%
        { { 327 },                                   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Automaton:Special attack damage+#%
        { { xi.augment.parametric.AUTOMATON, 1314 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [16] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12 } },
    },
    [17] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12 } },
    },
    [18] =
    {
        -- Weapon skill damage +#%
        { { 327 },                                   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Automaton:Special attack damage+#%
        { { xi.augment.parametric.AUTOMATON, 1314 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },                                    { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12 } },
    },
    [19] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [20] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [21] =
    {
        -- Evasion+#
        { { 22 },   { 0, 1, 3, 6, 9, 12, 15, 18, 21, 25, 29, 33, 37, 41, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100 } },
        -- TP during evasion +#
        { { 1294 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 50, 50, 50, 50, 50 } },
    },
    [22] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [23] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [24] =
    {
        -- Evasion+#
        { { 22 },   { 0, 1, 3, 6, 9, 12, 15, 18, 21, 25, 29, 33, 37, 41, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100 } },
        -- TP during evasion +#
        { { 1294 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 50, 50, 50, 50, 50 } },
    },
    [25] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 } },
    },
    [26] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 } },
    },
    [27] =
    {
        -- Evasion+#
        { { 22 },   { 0, 1, 3, 6, 9, 12, 15, 18, 21, 25, 29, 33, 37, 41, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100 } },
        -- TP during evasion +#
        { { 1294 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 50, 50, 50, 50, 50 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 } },
    },
    [28] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [29] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [30] =
    {
        -- Song spellcasting time -#%
        { { 322 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Song effects: "Double Attack"+#%
        { { 1295 }, { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4 } },
    },
    [31] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [32] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [33] =
    {
        -- Song spellcasting time -#%
        { { 322 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Song effects: "Double Attack"+#%
        { { 1295 }, { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4 } },
    },
    [34] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 } },
    },
    [35] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 } },
    },
    [36] =
    {
        -- Song spellcasting time -#%
        { { 322 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Song effects: "Double Attack"+#%
        { { 1295 }, { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 } },
    },
    [37] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [38] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [39] =
    {
        -- "Phantom Roll" effect duration +#
        { { 1608 }, { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 33, 36, 39, 42, 45, 48, 51, 53, 57, 60, 60, 60, 60, 60, 60 } },
        -- "Phantom Roll 11": Recover HP & MP +#%
        { { 1610 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- "Phantom Roll"+#
        { { 1609 }, { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8 } },
    },
    [40] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [41] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [42] =
    {
        -- "Phantom Roll" effect duration +#
        { { 1608 }, { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 33, 36, 39, 42, 45, 48, 51, 53, 57, 60, 60, 60, 60, 60, 60 } },
        -- "Phantom Roll 11": Recover HP & MP +#%
        { { 1610 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- "Phantom Roll"+#
        { { 1609 }, { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8 } },
    },
    [43] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 } },
    },
    [44] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 } },
    },
    [45] =
    {
        -- "Phantom Roll" effect duration +#
        { { 1608 }, { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 33, 36, 39, 42, 45, 48, 51, 53, 57, 60, 60, 60, 60, 60, 60 } },
        -- "Phantom Roll 11": Recover HP & MP +#%
        { { 1610 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- "Phantom Roll"+#
        { { 1609 }, { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8 } },
    },
    [46] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [47] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [48] =
    {
        -- "Flourish" recast time -#%
        { { 1611 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Step" duration +#
        { { 1612 }, { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 33, 36, 39, 42, 45, 48, 51, 53, 57, 60, 60, 60, 60, 60, 60 } },
    },
    [49] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [50] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [51] =
    {
        -- "Flourish" recast time -#%
        { { 1611 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Step" duration +#
        { { 1612 }, { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 33, 36, 39, 42, 45, 48, 51, 53, 57, 60, 60, 60, 60, 60, 60 } },
    },
    [52] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 } },
    },
    [53] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 } },
    },
    [54] =
    {
        -- "Flourish" recast time -#%
        { { 1611 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Step" duration +#
        { { 1612 }, { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 33, 36, 39, 42, 45, 48, 51, 53, 57, 60, 60, 60, 60, 60, 60 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 } },
    },
    [55] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [56] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [57] =
    {
        -- Sword enhancement spell damage +#%
        { { 515 },  { 0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240, 260, 280, 300, 320, 340, 360, 380, 400, 420, 440, 460, 480, 500, 500, 500, 500, 500, 500 } },
        -- Elemental weapon skill damage +#%
        { { 1293 }, { 0, 1, 3, 6, 9, 12, 15, 18, 21, 25, 29, 33, 37, 41, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100 } },
    },
    [58] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [59] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [60] =
    {
        -- Sword enhancement spell damage +#%
        { { 515 },  { 0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240, 260, 280, 300, 320, 340, 360, 380, 400, 420, 440, 460, 480, 500, 500, 500, 500, 500, 500 } },
        -- Elemental weapon skill damage +#%
        { { 1293 }, { 0, 1, 3, 6, 9, 12, 15, 18, 21, 25, 29, 33, 37, 41, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100 } },
    },
    [61] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [62] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [63] =
    {
        -- Sword enhancement spell damage +#%
        { { 515 },  { 0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240, 260, 280, 300, 320, 340, 360, 380, 400, 420, 440, 460, 480, 500, 500, 500, 500, 500, 500 } },
        -- Elemental weapon skill damage +#%
        { { 1293 }, { 0, 1, 3, 6, 9, 12, 15, 18, 21, 25, 29, 33, 37, 41, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [64] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [65] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [66] =
    {
        -- HP+#
        { { 9 },   { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 250, 250, 250, 250, 250 } },
        -- "Cure" potency +#%
        { { 329 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Refresh"+#
        { { 138 }, { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4 } },
    },
    [67] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [68] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [69] =
    {
        -- HP+#
        { { 9 },   { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 250, 250, 250, 250, 250 } },
        -- "Cure" potency +#%
        { { 329 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Refresh"+#
        { { 138 }, { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4 } },
    },
    [70] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [71] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [72] =
    {
        -- HP+#
        { { 9 },   { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 250, 250, 250, 250, 250 } },
        -- "Cure" potency +#%
        { { 329 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Refresh"+#
        { { 138 }, { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4 } },
    },
    [73] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [74] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [75] =
    {
        -- "Chain Affinity" recast time -#%
        { { 1606 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Burst Affinity" recast time -#%
        { { 1607 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [76] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [77] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [78] =
    {
        -- "Chain Affinity" recast time -#%
        { { 1606 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Burst Affinity" recast time -#%
        { { 1607 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [79] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [80] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [81] =
    {
        -- "Chain Affinity" recast time -#%
        { { 1606 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Burst Affinity" recast time -#%
        { { 1607 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [82] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [83] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [84] =
    {
        -- Potency of "Regen" effect received +#
        { { 1282 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Vivacious Pulse" potency +#%
        { { 1310 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 30, 30, 30, 30, 30 } },
    },
    [85] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [86] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [87] =
    {
        -- Potency of "Regen" effect received +#
        { { 1282 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Vivacious Pulse" potency +#%
        { { 1310 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 30, 30, 30, 30, 30 } },
    },
    [88] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 9, 9, 10, 10, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14 } },
    },
    [89] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 9, 9, 10, 10, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14 } },
    },
    [90] =
    {
        -- Potency of "Regen" effect received +#
        { { 1282 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Vivacious Pulse" potency +#%
        { { 1310 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 30, 30, 30, 30, 30 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 9, 9, 10, 10, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14 } },
    },
    [91] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [92] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [93] =
    {
        -- Damage taken -#%
        { { 55 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Pet:Damage taken +#%
        { { xi.augment.parametric.PET, 41 }, { 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5, -6, -7, -8, -9, -10, -10, -11, -11, -12, -12, -13, -13, -14, -14, -15, -15, -15, -15, -15, -15 } },
    },
    [94] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [95] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [96] =
    {
        -- Damage taken -#%
        { { 55 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Pet:Damage taken +#%
        { { xi.augment.parametric.PET, 41 }, { 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5, -6, -7, -8, -9, -10, -10, -11, -11, -12, -12, -13, -13, -14, -14, -15, -15, -15, -15, -15, -15 } },
    },
    [97] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11 } },
    },
    [98] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11 } },
    },
    [99] =
    {
        -- Damage taken -#%
        { { 55 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Pet:Damage taken +#%
        { { xi.augment.parametric.PET, 41 }, { 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5, -6, -7, -8, -9, -10, -10, -11, -11, -12, -12, -13, -13, -14, -14, -15, -15, -15, -15, -15, -15 } },
        -- DMG:+#
        { { 30 },                            { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11 } },
    },
    [100] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [101] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [102] =
    {
        -- TP gained when landing critical hits +#
        { { 1283 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- Critical hit rate +#%
        { { 26 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [103] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [104] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [105] =
    {
        -- TP gained when landing critical hits +#
        { { 1283 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- Critical hit rate +#%
        { { 26 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [106] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 9, 9, 10, 10, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14 } },
    },
    [107] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 9, 9, 10, 10, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14 } },
    },
    [108] =
    {
        -- TP gained when landing critical hits +#
        { { 1283 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- Critical hit rate +#%
        { { 26 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 9, 9, 10, 10, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14 } },
    },
    [109] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [110] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [111] =
    {
        -- "Drain" potency +#%
        { { 1284 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Weapon skill damage +#%
        { { 327 },  { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [112] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [113] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [114] =
    {
        -- "Drain" potency +#%
        { { 1284 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Weapon skill damage +#%
        { { 327 },  { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [115] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [116] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [117] =
    {
        -- "Drain" potency +#%
        { { 1284 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Weapon skill damage +#%
        { { 327 },  { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [118] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [119] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [120] =
    {
        -- Wyvern:HP+#
        { { xi.augment.parametric.WYVERN, 9 },  { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 250, 250, 250, 250, 250 } },
        -- Wyvern:Damage taken +#%
        { { xi.augment.parametric.WYVERN, 41 }, { 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5, -6, -7, -8, -9, -10, -10, -11, -11, -12, -12, -13, -13, -14, -14, -15, -15, -15, -15, -15, -15 } },
    },
    [121] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [122] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [123] =
    {
        -- Wyvern:HP+#
        { { xi.augment.parametric.WYVERN, 9 },  { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 250, 250, 250, 250, 250 } },
        -- Wyvern:Damage taken +#%
        { { xi.augment.parametric.WYVERN, 41 }, { 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5, -6, -7, -8, -9, -10, -10, -11, -11, -12, -12, -13, -13, -14, -14, -15, -15, -15, -15, -15, -15 } },
    },
    [124] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 9, 9, 10, 10, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14 } },
    },
    [125] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 9, 9, 10, 10, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14 } },
    },
    [126] =
    {
        -- Wyvern:HP+#
        { { xi.augment.parametric.WYVERN, 9 },  { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 250, 250, 250, 250, 250 } },
        -- Wyvern:Damage taken +#%
        { { xi.augment.parametric.WYVERN, 41 }, { 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5, -6, -7, -8, -9, -10, -10, -11, -11, -12, -12, -13, -13, -14, -14, -15, -15, -15, -15, -15, -15 } },
        -- DMG:+#
        { { 30 },                               { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 9, 9, 10, 10, 11, 12, 12, 13, 13, 14, 14, 14, 14, 14, 14 } },
    },
    [127] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [128] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [129] =
    {
        -- Ninjutsu recast time -#%
        { { 1301 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Enmity+# for each Utsusemi
        { { 379 },  { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [130] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [131] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [132] =
    {
        -- Ninjutsu recast time -#%
        { { 1301 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Enmity+# for each Utsusemi
        { { 379 },  { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [133] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [134] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [135] =
    {
        -- Ninjutsu recast time -#%
        { { 1301 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Enmity+# for each Utsusemi
        { { 379 },  { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [136] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [137] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [138] =
    {
        -- "Sekkanoki" recast time -#%
        { { 1604 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Sekkanoki": Weapon skill damage +#%
        { { 1605 }, { 0, 1, 3, 6, 9, 12, 15, 18, 21, 25, 29, 33, 37, 41, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100 } },
    },
    [139] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [140] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [141] =
    {
        -- "Sekkanoki" recast time -#%
        { { 1604 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Sekkanoki": Weapon skill damage +#%
        { { 1605 }, { 0, 1, 3, 6, 9, 12, 15, 18, 21, 25, 29, 33, 37, 41, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100 } },
    },
    [142] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 11, 11, 12, 12, 13, 13, 13, 13, 13, 13 } },
    },
    [143] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 11, 11, 12, 12, 13, 13, 13, 13, 13, 13 } },
    },
    [144] =
    {
        -- "Sekkanoki" recast time -#%
        { { 1604 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Sekkanoki": Weapon skill damage +#%
        { { 1605 }, { 0, 1, 3, 6, 9, 12, 15, 18, 21, 25, 29, 33, 37, 41, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 11, 11, 12, 12, 13, 13, 13, 13, 13, 13 } },
    },
    [145] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [146] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [147] =
    {
        -- "Afflatus Misery" stored +#%
        { { 1601 }, { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 250, 250, 250, 250, 250 } },
        -- Healing magic recast time -#%
        { { 1300 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Damage taken -#%
        { { 55 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [148] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [149] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [150] =
    {
        -- "Afflatus Misery" stored +#%
        { { 1601 }, { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 250, 250, 250, 250, 250 } },
        -- Healing magic recast time -#%
        { { 1300 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Damage taken -#%
        { { 55 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [151] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8 } },
    },
    [152] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8 } },
    },
    [153] =
    {
        -- "Afflatus Misery" stored +#%
        { { 1601 }, { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 250, 250, 250, 250, 250 } },
        -- Healing magic recast time -#%
        { { 1300 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Damage taken -#%
        { { 55 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [154] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [155] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [156] =
    {
        -- Magic burst damage II +#
        { { 1286 }, { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
        -- Magic burst accuracy+#
        { { 1287 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 30, 30, 30, 30, 30 } },
        -- "Drain" and "Aspir" potency +%d
        { { 343 },  { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 20, 20, 20, 20 } },
    },
    [157] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [158] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [159] =
    {
        -- Magic burst damage II +#
        { { 1286 }, { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
        -- Magic burst accuracy+#
        { { 1287 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 30, 30, 30, 30, 30 } },
        -- "Drain" and "Aspir" potency +%d
        { { 343 },  { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 20, 20, 20, 20 } },
    },
    [160] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8 } },
    },
    [161] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8 } },
    },
    [162] =
    {
        -- Magic burst damage II +#
        { { 1286 }, { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
        -- Magic burst accuracy+#
        { { 1287 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 30, 30, 30, 30, 30 } },
        -- "Drain" and "Aspir" potency +%d
        { { 343 },  { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 20, 20, 20, 20 } },
    },
    [163] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [164] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [165] =
    {
        -- MP+#
        { { 10 },   { 0, 1, 3, 6, 9, 12, 15, 18, 21, 25, 29, 33, 37, 41, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100 } },
        -- "Mana Wall"+#%
        { { 1304 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Damage taken -#%
        { { 55 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [166] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [167] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [168] =
    {
        -- MP+#
        { { 10 },   { 0, 1, 3, 6, 9, 12, 15, 18, 21, 25, 29, 33, 37, 41, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100 } },
        -- "Mana Wall"+#%
        { { 1304 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Damage taken -#%
        { { 55 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [169] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11 } },
    },
    [170] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11 } },
    },
    [171] =
    {
        -- MP+#
        { { 10 },   { 0, 1, 3, 6, 9, 12, 15, 18, 21, 25, 29, 33, 37, 41, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100 } },
        -- "Mana Wall"+#%
        { { 1304 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Damage taken -#%
        { { 55 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [172] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [173] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [174] =
    {
        -- Pet:Chance of double damage +#%
        { { xi.augment.parametric.PET, 1296 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 50, 50, 50, 50, 50 } },
        -- Chance of doubling "Blood Pact" status +#%
        { { 1308 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Blood Pact" damage +#
        { { 369 },                             { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [175] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [176] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [177] =
    {
        -- Pet:Chance of double damage +#%
        { { xi.augment.parametric.PET, 1296 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 50, 50, 50, 50, 50 } },
        -- Chance of doubling "Blood Pact" status +#%
        { { 1308 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Blood Pact" damage +#
        { { 369 },                             { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [178] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11 } },
    },
    [179] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11 } },
    },
    [180] =
    {
        -- Pet:Chance of double damage +#%
        { { xi.augment.parametric.PET, 1296 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 50, 50, 50, 50, 50 } },
        -- Chance of doubling "Blood Pact" status +#%
        { { 1308 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Blood Pact" damage +#
        { { 369 },                             { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
    },
    [181] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [182] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [183] =
    {
        -- "Regen" potency +#
        { { 371 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Cure" potency +#%
        { { 329 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Fast Cast"+#%
        { { 140 }, { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [184] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [185] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [186] =
    {
        -- "Regen" potency +#
        { { 371 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Cure" potency +#%
        { { 329 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Fast Cast"+#%
        { { 140 }, { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [187] =
    {
        -- Chance of double damage +#%
        { { 1296 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11 } },
    },
    [188] =
    {
        -- Chance of follow-up attack +#%
        { { 1298 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11 } },
    },
    [189] =
    {
        -- "Regen" potency +#
        { { 371 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Cure" potency +#%
        { { 329 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Fast Cast"+#%
        { { 140 }, { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [190] =
    {
        -- Chance of double ranged damage +#%
        { { 1297 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [191] =
    {
        -- Chance of ranged follow-up attack +#%
        { { 1299 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [192] =
    {
        -- Additional ammo damage +#%
        { { 1288 }, { 0, 10, 25, 40, 55, 70, 85, 100, 115, 130, 145, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 300, 300, 300, 300, 300 } },
        -- Additional ammo accuracy +#
        { { 1289 }, { 0, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 105, 110, 115, 120, 125, 130, 135, 140, 145, 150, 150, 150, 150, 150, 150 } },
    },
    [193] =
    {
        -- Chance of double ranged damage +#%
        { { 1297 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [194] =
    {
        -- Chance of ranged follow-up attack +#%
        { { 1299 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [195] =
    {
        -- Additional ammo damage +#%
        { { 1288 }, { 0, 10, 25, 40, 55, 70, 85, 100, 115, 130, 145, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 300, 300, 300, 300, 300 } },
        -- Additional ammo accuracy +#
        { { 1289 }, { 0, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 105, 110, 115, 120, 125, 130, 135, 140, 145, 150, 150, 150, 150, 150, 150 } },
    },
    [196] =
    {
        -- Chance of double ranged damage +#%
        { { 1297 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Store TP"+#
        { { 142 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6 } },
    },
    [197] =
    {
        -- Chance of ranged follow-up attack +#%
        { { 1299 }, { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- "Subtle Blow II"+#
        { { 1536 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6 } },
    },
    [198] =
    {
        -- Additional ammo damage +#%
        { { 1288 }, { 0, 10, 25, 40, 55, 70, 85, 100, 115, 130, 145, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270, 280, 290, 300, 300, 300, 300, 300, 300 } },
        -- Additional ammo accuracy +#
        { { 1289 }, { 0, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 105, 110, 115, 120, 125, 130, 135, 140, 145, 150, 150, 150, 150, 150, 150 } },
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6 } },
    },
    [199] =
    {
        -- HP+#
        { { 9 },                                        { 0, 1, 3, 6, 9, 12, 15, 18, 21, 25, 29, 33, 37, 41, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100 } },
        -- STR DEX +#
        { { xi.augment.parametric.STAT_COMBO, 0x0003 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- "Double Attack"+#%
        { { 143 },                                      { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [200] =
    {
        -- DEX MND +#
        { { xi.augment.parametric.STAT_COMBO, 0x0022 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- "Kick Attacks"+#
        { { 194 },                                      { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Physical damage limit +#%
        { { 380 },                                      { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [201] =
    {
        -- INT MND +#
        { { xi.augment.parametric.STAT_COMBO, 0x0030 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Enmity+#
        { { 29 },                                       { 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10, -11, -12, -13, -14, -15, -16, -17, -18, -19, -20, -21, -22, -23, -24, -25, -25, -25, -25, -25, -25 } },
        -- "Fast Cast"+#%
        { { 140 },                                      { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [202] =
    {
        -- INT MND +#
        { { xi.augment.parametric.STAT_COMBO, 0x0030 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Magic burst damage +#
        { { 1285 },                                     { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
        -- Magic burst accuracy+#
        { { 1287 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [203] =
    {
        -- INT MND +#
        { { xi.augment.parametric.STAT_COMBO, 0x0030 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Enhancing magic effect duration +#%
        { { 1248 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Enfeebling magic effect duration +#%
        { { 1251 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [204] =
    {
        -- DEX AGI +#
        { { xi.augment.parametric.STAT_COMBO, 0x000A }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Evasion+#
        { { 22 },                                       { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Triple Attack"+#%
        { { 144 },                                      { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4 } },
    },
    [205] =
    {
        -- HP+#
        { { 9 },                                        { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 60, 60, 60, 60, 60 } },
        -- VIT MND +#
        { { xi.augment.parametric.STAT_COMBO, 0x0024 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Damage taken -#%
        { { 55 },                                       { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [206] =
    {
        -- STR+#
        { { 11 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Store TP"+#
        { { 142 }, { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
        -- Physical damage limit +#%
        { { 380 }, { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [207] =
    {
        -- STR DEX +#
        { { xi.augment.parametric.STAT_COMBO, 0x0003 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Physical damage limit +#%
        { { 380 },                                      { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
        -- Pet:"Double Attack"+#%
        { { xi.augment.parametric.PET, 143 },           { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [208] =
    {
        -- DEX CHR +#
        { { xi.augment.parametric.STAT_COMBO, 0x0042 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Store TP"+#
        { { 142 },                                      { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
        -- Physical damage limit +#%
        { { 380 },                                      { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [209] =
    {
        -- AGI+#
        { { 14 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Store TP"+#
        { { 142 }, { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
        -- Physical damage limit +#%
        { { 380 }, { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [210] =
    {
        -- STR+#
        { { 11 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Store TP"+#
        { { 142 }, { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
        -- Physical damage limit +#%
        { { 380 }, { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [211] =
    {
        -- DEX AGI +#
        { { xi.augment.parametric.STAT_COMBO, 0x000A }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- "Daken"+#
        { { 251 },                                      { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Physical damage limit +#%
        { { 380 },                                      { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [212] =
    {
        -- STR VIT +#
        { { xi.augment.parametric.STAT_COMBO, 0x0005 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Physical damage limit +#%
        { { 380 },                                      { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
        -- Wyvern:Damage taken +#%
        { { xi.augment.parametric.WYVERN, 41 },         { 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10, -11, -12, -13, -14, -15, -16, -17, -18, -19, -20, -21, -22, -23, -24, -25, -25, -25, -25, -25, -25 } },
    },
    [213] =
    {
        -- MP+#
        { { 10 },                                                           { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- Avatar:All Attr.+#
        { { xi.augment.parametric.AVATAR, xi.augment.parametric.ALL_ATTR }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Blood Pact" damage +#
        { { 369 },                                                          { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [214] =
    {
        -- STR DEX +#
        { { xi.augment.parametric.STAT_COMBO, 0x0003 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Store TP"+#
        { { 142 },                                      { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
        -- Critical hit rate +#%
        { { 26 },                                       { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5 } },
    },
    [215] =
    {
        -- STR AGI +#
        { { xi.augment.parametric.STAT_COMBO, 0x0009 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Magic Damage+#
        { { 362 },                                      { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                                      { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [216] =
    {
        -- DEX AGI +#
        { { xi.augment.parametric.STAT_COMBO, 0x000A }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Physical damage limit +#%
        { { 380 },                                      { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
        -- Automaton:"Mag. Atk. Bns."+#
        { { xi.augment.parametric.AUTOMATON, 133 },     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
    },
    [217] =
    {
        -- DEX CHR +#
        { { xi.augment.parametric.STAT_COMBO, 0x0042 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- "Store TP"+#
        { { 142 },                                      { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
        -- Physical damage limit +#%
        { { 380 },                                      { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [218] =
    {
        -- INT MND +#
        { { xi.augment.parametric.STAT_COMBO, 0x0030 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Magic Damage+#
        { { 362 },                                      { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Helix eff. dur. +#%
        { { 1249 },                                     { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [219] =
    {
        -- MP+#
        { { 10 },                                 { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 50, 50, 50, 50, 50 } },
        -- Luopan duration +#%
        { { 1309 },                               { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25 } },
        -- Luopan:Absorbs damage taken +#%
        { { xi.augment.parametric.LUOPAN, 1313 }, { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10 } },
    },
    [220] =
    {
        -- HP+#
        { { 9 },                                        { 0, 1, 2, 4, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 60, 60, 60, 60, 60 } },
        -- STR MND +#
        { { xi.augment.parametric.STAT_COMBO, 0x0021 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 15, 15, 15, 15 } },
        -- Damage taken -#%
        { { 55 },                                       { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7 } },
    },
    [221] =
    {
        -- DMG:+#
        { { 30 },                                                              { 0, 1, 2, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24 } },
        -- "Final Heaven": DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.FINAL_HEAVEN }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- "Counter" damage +#%
        { { 1303 },                                                            { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [222] =
    {
        -- DMG:+#
        { { 30 },                                                               { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29 } },
        -- Ascetic's Fury: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.ASCETICS_FURY }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                           { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [223] =
    {
        -- DMG:+#
        { { 30 },                                                                  { 0, 1, 2, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24 } },
        -- Stringing Pummel: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.STRINGING_PUMMEL }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                              { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [224] =
    {
        -- DMG:+#
        { { 30 },                                                               { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Victory Smite: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.VICTORY_SMITE }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- STR DEX +#
        { { xi.augment.parametric.STAT_COMBO, 0x0003 },                         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [225] =
    {
        -- DMG:+#
        { { 30 },                                                              { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 } },
        -- Mercy Stroke: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.MERCY_STROKE }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- "Triple Attack" damage +#%
        { { 1305 },                                                            { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [226] =
    {
        -- DMG:+#
        { { 30 },                                                               { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 } },
        -- Pyrrhic Kleos: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.PYRRHIC_KLEOS }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                           { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [227] =
    {
        -- DMG:+#
        { { 30 },                                                               { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Mandalic Stab: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.MANDALIC_STAB }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                           { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [228] =
    {
        -- DMG:+#
        { { 30 },                                                              { 0, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14 } },
        -- Mordant Rime: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.MORDANT_RIME }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                          { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [229] =
    {
        -- DMG:+#
        { { 30 },                                                              { 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4 } },
        -- Rudra's Storm: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.RUDRAS_STORM }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- DEX AGI +#
        { { xi.augment.parametric.STAT_COMBO, 0x000A },                        { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [230] =
    {
        -- DMG:+#
        { { 30 },                                                                  { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9 } },
        -- Knights of Round: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.KNIGHTS_OF_ROUND }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Chance of successful block +#
        { { 363 },                                                                 { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [231] =
    {
        -- DMG:+#
        { { 30 },                                                               { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17 } },
        -- Death Blossom: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.DEATH_BLOSSOM }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                           { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [232] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- "Atonement" enmity+#
        { { 1292 },                                   { 0, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80, 90, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [233] =
    {
        -- DMG:+#
        { { 30 },                                                           { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 16, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18 } },
        -- Expiacion: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.EXPIACION }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                       { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [234] =
    {
        -- DMG:+#
        { { 30 },                                                                { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
        -- Chant du Cygne: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.CHANT_DU_CYGNE }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- DEX MND +#
        { { xi.augment.parametric.STAT_COMBO, 0x0022 },                          { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [235] =
    {
        -- DMG:+#
        { { 30 },                                                           { 0, 1, 1, 2, 2, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 } },
        -- Randgrith: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.RANDGRITH }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- "Cure" potency +#%
        { { 329 },                                                          { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [236] =
    {
        -- DMG:+#
        { { 30 },                                                             { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17 } },
        -- Mystic Boon: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.MYSTIC_BOON }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                         { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [237] =
    {
        -- DMG:+#
        { { 30 },                                       { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 } },
        -- "Dagan" potency +#%
        { { 1290 },                                     { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- AGI+# MND+# CHR+#
        { { xi.augment.parametric.BASE_STATS, 0x01A0 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [238] =
    {
        -- DMG:+#
        { { 30 },                                                           { 0, 1, 2, 3, 4, 5, 6, 7, 8, 10, 12, 14, 16, 18, 20, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22 } },
        -- Exudation: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.EXUDATION }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                       { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [239] =
    {
        -- DMG:+#
        { { 30 },                                                         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17 } },
        -- Scourge: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.SCOURGE }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Critical hit damage +#%
        { { 328 },                                                        { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [240] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11 } },
        -- Torcleaver: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.TORCLEAVER }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- STR VIT +#
        { { xi.augment.parametric.STAT_COMBO, 0x0005 },                      { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [241] =
    {
        -- DMG:+#
        { { 30 },                                                             { 0, 1, 3, 5, 7, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39 } },
        -- Dimidiation: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.DIMIDIATION }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                         { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [242] =
    {
        -- DMG:+#
        { { 30 },                                                           { 0, 1, 1, 2, 2, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 } },
        -- Onslaught: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.ONSLAUGHT }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Pet:"Double Attack"+#%
        { { xi.augment.parametric.PET, 143 },                               { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [243] =
    {
        -- DMG:+#
        { { 30 },                                                             { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Primal Rend: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.PRIMAL_REND }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                         { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [244] =
    {
        -- DMG:+#
        { { 30 },                                                               { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6 } },
        -- Cloudsplitter: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.CLOUDSPLITTER }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- STR DEX MND CHR +#
        { { xi.augment.parametric.STAT_COMBO, 0x0063 },                         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
    },
    [245] =
    {
        -- DMG:+#
        { { 30 },                                                                  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Metatron Torment: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.METATRON_TORMENT }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- "Double Attack" damage +#%
        { { 1302 },                                                                { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [246] =
    {
        -- DMG:+#
        { { 30 },                                                               { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 26, 29, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32 } },
        -- King's Justice: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.KINGS_JUSTICE }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                           { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [247] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 1, 2, 2, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 } },
        -- Ukko's Fury: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.UKKOS_FURY }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- STR DEX +#
        { { xi.augment.parametric.STAT_COMBO, 0x0003 },                      { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [248] =
    {
        -- DMG:+#
        { { 30 },                                                             { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13, 15, 17, 19, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21 } },
        -- Catastrophe: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.CATASTROPHE }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- "Drain" potency +#%
        { { 1284 },                                                           { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [249] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 22, 25, 28, 31, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34 } },
        -- Insurgency: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.INSURGENCY }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                        { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [250] =
    {
        -- DMG:+#
        { { 30 },                                                         { 0, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13 } },
        -- Quietus: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.QUIETUS }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- STR DEX INT MND +#
        { { xi.augment.parametric.STAT_COMBO, 0x0033 },                   { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
    },
    [251] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Geirskogul: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.GEIRSKOGUL }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- All Jumps: Damage+#%
        { { 1311 },                                                          { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
    },
    [252] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 26, 29, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32 } },
        -- Drakesbane: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.DRAKESBANE }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                        { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [253] =
    {
        -- DMG:+#
        { { 30 },                                                                  { 0, 1, 1, 2, 2, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 } },
        -- Camlann's Torment: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.CAMLANNS_TORMENT }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- STR VIT +#
        { { xi.augment.parametric.STAT_COMBO, 0x0005 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [254] =
    {
        -- DMG:+#
        { { 30 },                                                             { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8 } },
        -- Blade: Metsu: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.BLADE_METSU }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Ninjutsu casting time -#%
        { { 1307 },                                                           { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [255] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14 } },
        -- Blade: Kamu: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.BLADE_KAMU }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                        { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [256] =
    {
        -- DMG:+#
        { { 30 },                                                          { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
        -- Blade: Hi: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.BLADE_HI }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- DEX AGI +#
        { { xi.augment.parametric.STAT_COMBO, 0x000A },                    { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [257] =
    {
        -- DMG:+#
        { { 30 },                                                              { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 16, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18 } },
        -- Tachi: Kaiten: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.TACHI_KAITEN }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Skillchain dmg. +#%
        { { 332 },                                                             { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [258] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29 } },
        -- Tachi: Rana: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.TACHI_RANA }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                        { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [259] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11 } },
        -- Tachi: Fudo: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.TACHI_FUDO }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- STR AGI +#
        { { xi.augment.parametric.STAT_COMBO, 0x0009 },                      { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [260] =
    {
        -- DMG:+#
        { { 30 },                                                                  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 } },
        -- Gate of Tartarus: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.GATE_OF_TARTARUS }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Enmity+#
        { { 29 },                                                                  { 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10, -12, -14, -16, -18, -20, -20, -20, -20, -20, -20, -20, -20, -20, -20, -20, -20, -20, -20, -20, -20 } },
    },
    [261] =
    {
        -- DMG:+#
        { { 30 },                                                             { 0, 1, 2, 3, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26 } },
        -- Omniscience: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.OMNISCIENCE }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                         { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [262] =
    {
        -- DMG:+#
        { { 30 },                                                           { 0, 1, 2, 3, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26 } },
        -- Vidohunir: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.VIDOHUNIR }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                       { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [263] =
    {
        -- DMG:+#
        { { 30 },                                                                  { 0, 1, 2, 3, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26 } },
        -- Garland of Bliss: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.GARLAND_OF_BLISS }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Avatar:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.AVATAR, 100 },                                   { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [264] =
    {
        -- DMG:+#
        { { 30 },   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- "Myrkr" potency +#%
        { { 1291 }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- MP+#
        { { 10 },   { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [265] =
    {
        -- DMG:+#
        { { 30 },                                                             { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 0, 7 } },
        -- Namas Arrow: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.NAMAS_ARROW }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Critical hit rate +#%
        { { 26 },                                                             { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [266] =
    {
        -- DMG:+#
        { { 30 },                                                                  { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 } },
        -- Jishnu's Radiance: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.JISHNUS_RADIANCE }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- STR DEX +#
        { { xi.augment.parametric.STAT_COMBO, 0x0003 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [267] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
        -- Trueflight: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.TRUEFLIGHT }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 },                        { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [268] =
    {
        -- DMG:+#
        { { 30 },                                                          { 0, 1, 1, 2, 2, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 } },
        -- Coronach: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.CORONACH }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- "Store TP"+#
        { { 142 },                                                         { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [269] =
    {
        -- DMG:+#
        { { 30 },                                                               { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6 } },
        -- Leaden Salute: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.LEADEN_SALUTE }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 },                           { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [270] =
    {
        -- DMG:+#
        { { 30 },                                                          { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8 } },
        -- Wildfire: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.WILDFIRE }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- STR AGI +#
        { { xi.augment.parametric.STAT_COMBO, 0x0009 },                    { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [271] =
    {
        -- DMG:+#
        { { 30 },                                                               { 0, 1, 2, 3, 4, 5, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24 } },
        -- Shijin Spiral: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.SHIJIN_SPIRAL }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                           { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [272] =
    {
        -- DMG:+#
        { { 30 },                                                             { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6 } },
        -- Exenterator: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.EXENTERATOR }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                         { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [273] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8 } },
        -- Requiescat: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.REQUIESCAT }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                        { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [274] =
    {
        -- DMG:+#
        { { 30 },                                                          { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 } },
        -- Upheaval: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.UPHEAVAL }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                      { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [275] =
    {
        -- DMG:+#
        { { 30 },                                                         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17 } },
        -- Entropy: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.ENTROPY }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                     { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [276] =
    {
        -- DMG:+#
        { { 30 },                                                           { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Stardiver: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.STARDIVER }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                       { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [277] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 } },
        -- Blade: Shun: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.BLADE_SHUN }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                        { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [278] =
    {
        -- DMG:+#
        { { 30 },                                                             { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Tachi: Shoha: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.TACHI_SHOHA }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                         { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [279] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8 } },
        -- Realmrazer: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.REALMRAZER }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                        { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [280] =
    {
        -- DMG:+#
        { { 30 },                                                             { 0, 1, 2, 3, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26 } },
        -- Shattersoul: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.SHATTERSOUL }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                         { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [281] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 } },
        -- Resolution: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.RESOLUTION }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                        { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [282] =
    {
        -- DMG:+#
        { { 30 },                                                          { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9 } },
        -- Ruinator: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.RUINATOR }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                      { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [283] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 } },
        -- Apex Arrow: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.APEX_ARROW }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 },                        { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [284] =
    {
        -- DMG:+#
        { { 30 },                                                            { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9 } },
        -- Last Stand: DMG:+#%
        { { xi.augment.parametric.WEAPON_SKILL, xi.weaponskill.LAST_STAND }, { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 },                        { 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [285] =
    {
        -- Healing magic skill +#
        { { 288 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Enha. mag. skill +#
        { { 289 },                            { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [286] =
    {
        -- Accuracy+#
        { { 18 }, { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 23, 26, 29, 32, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35 } },
        -- Mag. Evasion+#
        { { 25 }, { 0, 0, 0, 0, 0, 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100 } },
        -- Critical hit rate +#%
        { { 26 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [287] =
    {
        -- Mag. Evasion+#
        { { 25 },                             { 0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75, 75 } },
        -- Occ. inc. resist. to stat. ailments +#
        { { 50 },                             { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [288] =
    {
        -- Accuracy+#
        { { 18 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Evasion+#
        { { 22 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [289] =
    {
        -- Avatar:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.AVATAR, 100 },                            { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 23, 26, 29, 32, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35 } },
        -- Avatar:All Attr.+#
        { { xi.augment.parametric.AVATAR, xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- MP+#
        { { 10 },                                                           { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [290] =
    {
        -- "Resist Silence"+#
        { { 180 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Spell interruption rate down %d%%
        { { 36 },  { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [291] =
    {
        -- Attack+#
        { { 19 },                             { 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                            { 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [292] =
    {
        -- STR+#
        { { 11 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- "Double Attack"+#%
        { { 143 }, { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [293] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25 } },
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [294] =
    {
        -- "Conserve MP"+#
        { { 141 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- "Fast Cast"+#%
        { { 140 }, { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [295] =
    {
        -- Mag. Acc.+#
        { { 24 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- INT+#
        { { 15 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [296] =
    {
        -- Mag. Acc.+#
        { { 24 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- CHR+#
        { { 17 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [297] =
    {
        -- Evasion+#
        { { 22 },                             { 0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90 } },
        -- Mag. Evasion+#
        { { 25 },                             { 0, 0, 0, 0, 0, 0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [298] =
    {
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Accuracy+#
        { { 18 },                             { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [299] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 10, 15, 20, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25 } },
    },
    [300] =
    {
        -- HP+#
        { { 9 },                                      { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150 } },
        -- Shield skill +#
        { { 285 },                                    { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [301] =
    {
        -- "Snapshot"+#
        { { 211 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- DMG:+#
        { { 30 },  { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Rng. Acc.+#
        { { 20 },  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [302] =
    {
        -- "Resist Sleep"+#
        { { 176 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- "Resist Charm"+#
        { { 188 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 7, 9, 11, 13, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
    },
    [303] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [304] =
    {
        -- Mag. Acc.+#
        { { 24 },                             { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- Damage taken -#%
        { { 55 },                             { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [305] =
    {
        -- DEF+#
        { { 23 }, { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- HP+#
        { { 9 },  { 0, 0, 0, 0, 0, 0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200 } },
    },
    [306] =
    {
        -- Mag. Acc.+#
        { { 24 },                                       { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- INT MND CHR +#
        { { xi.augment.parametric.STAT_COMBO, 0x0070 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [307] =
    {
        -- TP Bonus +#
        { { 353 },                                    { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 34, 38, 42, 46, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- STR+#
        { { 11 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [308] =
    {
        -- Accuracy+#
        { { 18 },                             { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Critical hit rate +#%
        { { 26 },                             { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [309] =
    {
        -- "Resist Bind"+#
        { { 185 },                            { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- Evasion+#
        { { 22 },                             { 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [310] =
    {
        -- DEF+#
        { { 23 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- "Mag. Def. Bns."+#
        { { 134 }, { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [311] =
    {
        -- Mag. Acc.+#
        { { 24 },                             { 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60 } },
        -- Spell interruption rate down %d%%
        { { 36 },                             { 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [312] =
    {
        -- DEF+#
        { { 23 },                                       { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- STR DEX VIT INT +#
        { { xi.augment.parametric.STAT_COMBO, 0x0017 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 6, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8 } },
    },
    [313] =
    {
        -- DEF+#
        { { 23 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Parrying skill +#
        { { 286 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [314] =
    {
        -- Attack+#
        { { 19 },                             { 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60 } },
        -- "Store TP"+#
        { { 142 },                            { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [315] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Critical hit rate +#%
        { { 26 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [316] =
    {
        -- VIT+#
        { { 13 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- HP+#
        { { 9 },  { 0, 0, 0, 0, 0, 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100 } },
    },
    [317] =
    {
        -- DEX AGI +#
        { { xi.augment.parametric.STAT_COMBO, 0x000A }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Mag. Evasion+#
        { { 25 },                                       { 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR },           { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [318] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Weapon skill damage +#%
        { { 327 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
    },
    [319] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 3, 6, 9, 12, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Quadruple Attack +#%
        { { 354 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 } },
    },
    [320] =
    {
        -- Accuracy+#
        { { 18 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- DEX+#
        { { 12 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [321] =
    {
        -- Healing magic skill +#
        { { 288 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Enha. mag. skill +#
        { { 289 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Damage taken -#%
        { { 55 },  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [322] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 3, 6, 9, 12, 15, 18, 21, 24, 26, 28, 30, 32, 34, 36, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38, 38 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Sword enhancement spell damage +#%
        { { 515 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 60, 90, 120, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150 } },
    },
    [323] =
    {
        -- Evasion+#
        { { 22 },                             { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Accuracy+#
        { { 18 },                             { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [324] =
    {
        -- Skillchain dmg. +#%
        { { 332 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Magic burst damage +#
        { { 1285 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [325] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- Attack+#
        { { 19 },                                     { 0, 0, 0, 0, 0, 0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR },         { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [326] =
    {
        -- Accuracy+#
        { { 18 },                             { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- "Double Attack"+#%
        { { 143 },                            { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [327] =
    {
        -- Attack+#
        { { 19 }, { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- STR+#
        { { 11 }, { 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
    },
    [328] =
    {
        -- Avatar:TP Bonus +#
        { { xi.augment.parametric.AVATAR, 53 },                             { 0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240, 260, 280, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300 } },
        -- Avatar:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.AVATAR, 100 },                            { 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Avatar:All Attr.+#
        { { xi.augment.parametric.AVATAR, xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [329] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Physical damage limit +#%
        { { 380 },                                    { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR },         { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [330] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Critical hit rate +#%
        { { 26 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [331] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR },         { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [332] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Evasion+#
        { { 22 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [333] =
    {
        -- "Mag. Atk. Bns."+#
        { { 133 },                                      { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 32, 34, 36, 38, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },   { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- INT MND +#
        { { xi.augment.parametric.STAT_COMBO, 0x0030 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [334] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 47, 50, 53, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Critical hit rate +#%
        { { 26 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [335] =
    {
        -- "Cure" potency +#%
        { { 329 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Healing magic skill +#
        { { 288 },                            { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [336] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Weapon skill damage +#%
        { { 327 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [337] =
    {
        -- "Conserve MP"+#
        { { 141 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- INT+#
        { { 15 },  { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [338] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 5, 10, 15, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8 } },
    },
    [339] =
    {
        -- Chance of successful block +#
        { { 363 }, { 0, 1, 2, 3, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Enh. Mag. received dur. +#%
        { { 374 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [340] =
    {
        -- Rng. Atk.+#
        { { 21 },                                     { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 }, { 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- "Snapshot"+#
        { { 211 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [341] =
    {
        -- Phys. dmg. taken +#%
        { { 37 },                             { 0, -1, -2, -3, -4, -5, -5, -6, -6, -7, -7, -8, -8, -9, -9, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10, -10 } },
        -- Pet:Damage taken +#%
        { { xi.augment.parametric.PET, 41 },  { 0, 0, 0, 0, 0, 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [342] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 4, 8, 12, 16, 20, 24, 27, 30, 33, 36, 39, 42, 45, 48, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- "Fast Cast"+#%
        { { 140 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [343] =
    {
        -- Magic Damage+#
        { { 362 }, { 0, 1, 2, 3, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- INT+#
        { { 15 },  { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [344] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- "Triple Attack"+#%
        { { 144 },                                    { 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 } },
        -- Quadruple Attack +#%
        { { 354 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 } },
    },
    [345] =
    {
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR },         { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Evasion+#
        { { 22 },                                     { 0, 0, 0, 0, 0, 0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50 } },
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 10, 15, 20, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25 } },
    },
    [346] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- "Regen"+#
        { { 137 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [347] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 4, 8, 12, 16, 20, 24, 28, 32, 35, 38, 41, 44, 47, 50, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 53 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Haste+#%
        { { 32 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [348] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Shield skill +#
        { { 285 },                                    { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [349] =
    {
        -- DMG:+#
        { { 30 },  { 0, 1, 2, 3, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9 } },
        -- Rng. Acc.+#
        { { 20 },  { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- "Rapid Shot"+#
        { { 139 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
    },
    [350] =
    {
        -- Evasion+#
        { { 22 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- "Counter"+#
        { { 145 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [351] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- DEX+#
        { { 12 },                                     { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Sword enhancement spell damage +#%
        { { 515 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 20, 30, 40, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50 } },
    },
    [352] =
    {
        -- MP+#
        { { 10 },                                 { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- Avatar:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.AVATAR, 100 },  { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Avatar:Magic burst damage +#
        { { xi.augment.parametric.AVATAR, 1285 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [353] =
    {
        -- Avatar:All Attr.+#
        { { xi.augment.parametric.AVATAR, xi.augment.parametric.ALL_ATTR }, { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Avatar:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.AVATAR, 100 },                            { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- "Avatar perpetuation cost" -%d
        { { 321 },                                                          { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [354] =
    {
        -- Mag. Acc.+#
        { { 24 },                             { 0, 10, 20, 30, 40, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                            { 0, 0, 0, 0, 0, 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [355] =
    {
        -- STR+#
        { { 11 }, { 0, 1, 2, 3, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- DEX+#
        { { 12 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [356] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 19, 20, 21, 22, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 20, 30, 40, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50 } },
    },
    [357] =
    {
        -- HP+#
        { { 9 },   { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- Chance of successful block +#
        { { 363 }, { 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 } },
    },
    [358] =
    {
        -- DEX+#
        { { 12 }, { 0, 1, 2, 3, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- AGI+#
        { { 14 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [359] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },   { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- Critical hit rate +#%
        { { 26 },                                       { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- STR DEX +#
        { { xi.augment.parametric.STAT_COMBO, 0x0003 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 10, 15, 20, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25 } },
    },
    [360] =
    {
        -- "Fast Cast"+#%
        { { 140 }, { 0, 1, 2, 3, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Spell interruption rate down %d%%
        { { 36 },  { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [361] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- "Mag. Def. Bns."+#
        { { 134 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [362] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Skillchain dmg. +#%
        { { 332 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
    },
    [363] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },   { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 21, 22, 23, 24, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25 } },
        -- INT MND +#
        { { xi.augment.parametric.STAT_COMBO, 0x0030 }, { 0, 0, 0, 0, 0, 0, 3, 6, 9, 12, 15, 17, 19, 21, 23, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25 } },
    },
    [364] =
    {
        -- STR+#
        { { 11 }, { 0, 1, 2, 3, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Haste+#%
        { { 32 }, { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [365] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 3, 6, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Weapon skill damage +#%
        { { 327 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [366] =
    {
        -- Accuracy+#
        { { 18 },                             { 0, 4, 8, 12, 16, 20, 24, 27, 30, 33, 36, 39, 42, 45, 47, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50 } },
        -- Haste+#%
        { { 32 },                             { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [367] =
    {
        -- DEF+#
        { { 23 }, { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- Damage taken -#%
        { { 55 }, { 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 } },
    },
    [368] =
    {
        -- Rng. Atk.+#
        { { 21 },                                     { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Enmity+#
        { { 29 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -2, -3, -4, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5, -5 } },
    },
    [369] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 27, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28, 28 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Pot. of "Cure" effect rec. +#%
        { { 356 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [370] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 3, 6, 9, 12, 15, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 20, 30, 40, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50 } },
    },
    [371] =
    {
        -- DMG:+#
        { { 30 },  { 0, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17 } },
        -- Rng. Acc.+#
        { { 20 },  { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- "Snapshot"+#
        { { 211 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [372] =
    {
        -- DEF+#
        { { 23 }, { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- Spell interruption rate down %d%%
        { { 36 }, { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [373] =
    {
        -- Mag. Evasion+#
        { { 25 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- "Double Attack"+#%
        { { 143 }, { 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 } },
    },
    [374] =
    {
        -- Accuracy+#
        { { 18 }, { 0, 1, 2, 3, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- DEX+#
        { { 12 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 3, 4, 4, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6 } },
    },
    [375] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 3, 6, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Dark magic skill +#
        { { 292 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [376] =
    {
        -- Enmity+#
        { { 29 },                             { 0, 1, 2, 3, 4, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Damage taken -#%
        { { 55 },                             { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [377] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 2, 4, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [378] =
    {
        -- Rng. Atk.+#
        { { 21 },                                     { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- DMG:+#
        { { 30 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [379] =
    {
        -- Accuracy+#
        { { 18 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Mag. Acc.+#
        { { 24 },  { 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Enha. mag. skill +#
        { { 289 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [380] =
    {
        -- Mag. Evasion+#
        { { 25 },                             { 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60 } },
        -- Enmity+#
        { { 29 },                             { 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [381] =
    {
        -- DMG:+#
        { { 30 },                                       { 0, 2, 4, 6, 8, 10, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },   { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- STR DEX CHR +#
        { { xi.augment.parametric.STAT_COMBO, 0x0043 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },           { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 32, 34, 36, 38, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
    },
    [382] =
    {
        -- Accuracy+#
        { { 18 },                             { 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- "Triple Attack"+#%
        { { 144 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 } },
    },
    [383] =
    {
        -- Accuracy+#
        { { 18 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- "Store TP"+#
        { { 142 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [384] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Attack+#
        { { 19 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 16, 24, 32, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
    },
    [385] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- HP+#
        { { 9 },                                      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 40, 60, 80, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100 } },
    },
    [386] =
    {
        -- Accuracy+#
        { { 18 },                             { 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- "Triple Attack"+#%
        { { 144 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 } },
    },
    [387] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- Damage taken -#%
        { { 55 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [388] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 12, 18, 24, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
    },
    [389] =
    {
        -- Accuracy+#
        { { 18 },                             { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 32, 34, 36, 38, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- "Triple Attack"+#%
        { { 144 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4 } },
    },
    [390] =
    {
        -- DEX+#
        { { 12 },                                     { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 32, 34, 36, 38, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40 } },
    },
    [391] =
    {
        -- Mag. Acc.+#
        { { 24 },  { 0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 54, 58, 62, 66, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70, 70 } },
        -- Enfb. mag. skill +#
        { { 290 }, { 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20 } },
        -- MND+#
        { { 16 },  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
    },
    [392] =
    {
        -- Accuracy+#
        { { 18 },                             { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 } },
        -- "Triple Attack"+#%
        { { 144 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 } },
    },
    [393] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 16, 16, 16, 17, 17, 17, 18, 18, 18, 19, 19, 19, 19, 20 } },
        -- Attack+#
        { { 19 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Skillchain dmg. +#%
        { { 332 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [394] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 11 } },
        -- Attack+#
        { { 19 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Subtle Blow II"+#
        { { 1536 },                                   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [395] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 11, 11, 11, 12, 12, 12, 13 } },
        -- Attack+#
        { { 19 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Refresh"+#
        { { 138 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3 } },
    },
    [396] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 22, 23, 23, 24, 24, 25, 25, 26 } },
        -- Attack+#
        { { 19 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Counter"+#
        { { 145 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [397] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 11, 11, 11, 12, 12, 12, 13, 13, 13, 14, 14, 14, 14, 15 } },
        -- Attack+#
        { { 19 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- TP Bonus +#
        { { 353 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 20, 20, 30, 30, 40, 40, 50, 50 } },
    },
    [398] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 11, 11, 11, 12, 12, 12, 13, 13, 13, 14, 14, 14, 14, 15 } },
        -- Attack+#
        { { 19 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Skillchain dmg. +#%
        { { 332 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [399] =
    {
        -- DMG:+#
        { { 30 },                                       { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 24, 25, 25, 26, 26, 27 } },
        -- Attack+#
        { { 19 },                                       { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- STR VIT +#
        { { xi.augment.parametric.STAT_COMBO, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [400] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 26, 27, 27, 28 } },
        -- Attack+#
        { { 19 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Damage taken -#%
        { { 55 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [401] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 22, 23, 23, 24, 24, 25, 25, 26 } },
        -- Attack+#
        { { 19 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Regen"+#
        { { 137 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3 } },
    },
    [402] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 10, 11, 11, 11, 11, 11, 12 } },
        -- Attack+#
        { { 19 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Daken"+#
        { { 251 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [403] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 18, 19, 19, 20, 20, 21, 21, 22, 22, 23, 23, 24 } },
        -- Attack+#
        { { 19 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- STR+#
        { { 11 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [404] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 11 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                                    { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Enmity+#
        { { 29 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5 } },
    },
    [405] =
    {
        -- DMG:+#
        { { 30 },                                       { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 16, 16, 17, 17, 18, 18, 18, 19, 19, 19, 20, 20, 20, 21 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                                      { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- INT MND +#
        { { xi.augment.parametric.STAT_COMBO, 0x0030 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [406] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 8, 9 } },
        -- Rng. Atk.+#
        { { 21 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Snapshot"+#
        { { 211 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [407] =
    {
        -- DMG:+#
        { { 30 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 16, 16, 17, 17, 18, 18, 18, 19, 19, 19, 20, 20, 20, 21 } },
        -- Rng. Atk.+#
        { { 21 },                                     { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Recycle"+#
        { { 212 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [408] =
    {
        -- Rng. Atk.+#
        { { 21 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                                    { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Subtle Blow II"+#
        { { 1536 },                                   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [409] =
    {
        -- Rng. Atk.+#
        { { 21 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- TP Bonus +#
        { { 353 },                                    { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 16, 16, 17, 17, 17, 18, 18, 18, 19, 19, 19, 19, 19, 20 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Critical hit rate +#%
        { { 26 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [410] =
    {
        -- Rng. Atk.+#
        { { 21 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Subtle Blow"+#
        { { 195 },                                    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 15 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Recycle"+#
        { { 212 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [411] =
    {
        -- Rng. Atk.+#
        { { 21 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Damage taken -#%
        { { 55 },                                     { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- STR+#
        { { 11 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [412] =
    {
        -- Rng. Atk.+#
        { { 21 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "True Shot"+#
        { { 232 },                                    { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10 } },
        -- Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0006 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- AGI+#
        { { 14 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [413] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Counter"+#
        { { 145 },                                    { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Regen"+#
        { { 137 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3 } },
    },
    [414] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Double Attack"+#%
        { { 143 },                                    { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Occ. inc. resist. to stat. ailments +#
        { { 50 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [415] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- DEX+#
        { { 12 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [416] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Subtle Blow"+#
        { { 195 },                                    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Triple Attack"+#%
        { { 144 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [417] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Evasion+#
        { { 22 },                                     { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- STR+#
        { { 11 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [418] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Double Attack" damage +#%
        { { 1302 },                                   { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Cure" potency +#%
        { { 329 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [419] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Occ. inc. resist. to stat. ailments +#
        { { 50 },                                     { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Critical hit rate +#%
        { { 26 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [420] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- VIT+#
        { { 13 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [421] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Skillchain dmg. +#%
        { { 332 },                                    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- STR+#
        { { 11 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [422] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Subtle Blow"+#
        { { 195 },                                    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Chance of successful block +#
        { { 363 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [423] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Skillchain dmg. +#%
        { { 332 },                                    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Double Attack"+#%
        { { 143 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [424] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Regen"+#
        { { 137 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3 } },
    },
    [425] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Triple Attack" damage +#%
        { { 1305 },                                   { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- DEX+#
        { { 12 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [426] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Physical damage limit +#%
        { { 380 },                                    { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Mag. Evasion+#
        { { 25 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [427] =
    {
        -- Attack+#
        { { 19 },                                     { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                                    { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- AGI+#
        { { 14 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [428] =
    {
        -- "Mag. Atk. Bns."+#
        { { 133 },                                    { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 21, 22, 22, 23, 23, 24, 24, 25, 25 } },
        -- Magic Damage+#
        { { 362 },                                    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Enmity+#
        { { 29 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5 } },
    },
    [429] =
    {
        -- "Mag. Atk. Bns."+#
        { { 133 },                                    { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 21, 22, 22, 23, 23, 24, 24, 25, 25 } },
        -- Enmity+#
        { { 29 },                                     { 0, -1, -1, -1, -1, -2, -2, -2, -2, -3, -3, -3, -3, -4, -4, -4, -4, -5, -5, -5, -5, -6, -6, -6, -6, -7, -7, -7, -7, -8, -8 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Magic Damage+#
        { { 362 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [430] =
    {
        -- "Mag. Atk. Bns."+#
        { { 133 },                                    { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 21, 22, 22, 23, 23, 24, 24, 25, 25 } },
        -- Magic burst damage II +#
        { { 1286 },                                   { 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- MND+#
        { { 16 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [431] =
    {
        -- "Mag. Atk. Bns."+#
        { { 133 },                                    { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 21, 22, 22, 23, 23, 24, 24, 25, 25 } },
        -- Damage taken -#%
        { { 55 },                                     { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- INT+#
        { { 15 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [432] =
    {
        -- "Mag. Atk. Bns."+#
        { { 133 },                                    { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 21, 22, 22, 23, 23, 24, 24, 25, 25 } },
        -- "Drain" and "Aspir" potency +%d
        { { 343 },                                    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 14, 15 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Spell interruption rate down %d%%
        { { 36 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [433] =
    {
        -- Attack+# Magic Damage+#
        { { xi.augment.parametric.ATTACK, 0x0009 },   { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Quadruple Attack +#%
        { { 354 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3 } },
    },
    [434] =
    {
        -- Attack+# Magic Damage+#
        { { xi.augment.parametric.ATTACK, 0x0009 },   { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Physical damage limit +#%
        { { 380 },                                    { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- DEX+#
        { { 12 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [435] =
    {
        -- Attack+# Magic Damage+#
        { { xi.augment.parametric.ATTACK, 0x0009 },   { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Magic burst damage II +#
        { { 1286 },                                   { 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- MND+#
        { { 16 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [436] =
    {
        -- Attack+# Magic Damage+#
        { { xi.augment.parametric.ATTACK, 0x0009 },   { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Blood Pact" damage +#
        { { 369 },                                    { 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Pet:Damage taken +#%
        { { xi.augment.parametric.PET, 41 },          { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5 } },
    },
    [437] =
    {
        -- Attack+# Magic Damage+#
        { { xi.augment.parametric.ATTACK, 0x0009 },                         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Regen" potency +#
        { { 371 },                                                          { 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10 } },
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                       { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Avatar:All Attr.+#
        { { xi.augment.parametric.AVATAR, xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [438] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 11, 11, 11, 12, 12, 12, 13 } },
        -- Physical damage limit +#%
        { { 380 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5 } },
        -- Critical hit rate +#%
        { { 26 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [439] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 },   { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                      { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15 } },
        -- Physical damage limit +#%
        { { 380 },                                      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7 } },
        -- DEX AGI +#
        { { xi.augment.parametric.STAT_COMBO, 0x000A }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [440] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 13, 14, 14, 14 } },
        -- Physical damage limit +#%
        { { 380 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5 } },
        -- DEX+#
        { { 12 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15 } },
    },
    [441] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 11, 11, 11, 12, 12, 12, 13 } },
        -- Physical damage limit +#%
        { { 380 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6 } },
        -- Critical hit rate +#%
        { { 26 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 7, 8, 9, 10, 11, 12, 13 } },
    },
    [442] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 11, 11, 11, 12, 12, 12, 13 } },
        -- Physical damage limit +#%
        { { 380 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5 } },
        -- AGI+#
        { { 14 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15 } },
    },
    [443] =
    {
        -- Attack+# Rng. Atk.+#
        { { xi.augment.parametric.ATTACK, 0x0003 },   { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35 } },
        -- Weapon skill damage +#%
        { { 327 },                                    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 11, 11, 11 } },
        -- "Double Attack"+#%
        { { 143 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5 } },
        -- Accuracy+# Rng. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0003 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [444] =
    {
        -- Attack+# Rng. Atk.+#
        { { xi.augment.parametric.ATTACK, 0x0003 },     { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35 } },
        -- Weapon skill damage +#%
        { { 327 },                                      { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10, 11, 11, 11, 12, 12, 12, 13, 13, 13 } },
        -- "Double Attack"+#%
        { { 143 },                                      { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7 } },
        -- STR VIT +#
        { { xi.augment.parametric.STAT_COMBO, 0x0005 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [445] =
    {
        -- Attack+# Rng. Atk.+#
        { { xi.augment.parametric.ATTACK, 0x0003 }, { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35 } },
        -- Weapon skill damage +#%
        { { 327 },                                  { 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 11, 11, 11 } },
        -- "Double Attack"+#%
        { { 143 },                                  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5 } },
        -- VIT+#
        { { 13 },                                   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15 } },
    },
    [446] =
    {
        -- Attack+# Rng. Atk.+#
        { { xi.augment.parametric.ATTACK, 0x0003 }, { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35 } },
        -- Weapon skill damage +#%
        { { 327 },                                  { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 11, 11, 11, 12, 12, 12 } },
        -- "Double Attack"+#%
        { { 143 },                                  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6 } },
        -- STR+#
        { { 11 },                                   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15 } },
    },
    [447] =
    {
        -- Attack+# Rng. Atk.+#
        { { xi.augment.parametric.ATTACK, 0x0003 },   { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35 } },
        -- Weapon skill damage +#%
        { { 327 },                                    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 11, 11, 11 } },
        -- "Double Attack"+#%
        { { 143 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5 } },
        -- Accuracy+# Rng. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0003 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 7, 8, 9, 10, 11, 12, 13 } },
    },
    [448] =
    {
        -- "Mag. Atk. Bns."+#
        { { 133 },  { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35 } },
        -- Magic Damage+#
        { { 362 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Magic burst damage II +#
        { { 1286 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6 } },
        -- Mag. Acc.+#
        { { 24 },   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [449] =
    {
        -- "Mag. Atk. Bns."+#
        { { 133 },                                      { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35 } },
        -- Magic Damage+#
        { { 362 },                                      { 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40 } },
        -- Magic burst damage II +#
        { { 1286 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7 } },
        -- INT MND CHR +#
        { { xi.augment.parametric.STAT_COMBO, 0x0070 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [450] =
    {
        -- "Mag. Atk. Bns."+#
        { { 133 },  { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35 } },
        -- Magic Damage+#
        { { 362 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Magic burst damage II +#
        { { 1286 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5 } },
        -- MND+#
        { { 16 },   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15 } },
    },
    [451] =
    {
        -- "Mag. Atk. Bns."+#
        { { 133 },  { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35 } },
        -- Magic Damage+#
        { { 362 },  { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35 } },
        -- Magic burst damage II +#
        { { 1286 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5 } },
        -- INT+#
        { { 15 },   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15 } },
    },
    [452] =
    {
        -- "Mag. Atk. Bns."+#
        { { 133 },  { 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35 } },
        -- Magic Damage+#
        { { 362 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Magic burst damage II +#
        { { 1286 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5 } },
        -- CHR+#
        { { 17 },   { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15 } },
    },
    [453] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                    { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Pet:All Attr.+#
        { { xi.augment.parametric.PET, xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Pet:Damage taken +#%
        { { xi.augment.parametric.PET, 41 },                             { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -2, -3, -4, -5, -6, -6, -7, -7, -8 } },
    },
    [454] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Pet:DMG:+#%
        { { xi.augment.parametric.PET, 47 },          { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11 } },
        -- Pet:Damage taken +#%
        { { xi.augment.parametric.PET, 41 },          { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10 } },
    },
    [455] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                    { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Pet:All Attr.+#
        { { xi.augment.parametric.PET, xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Pet:Damage taken +#%
        { { xi.augment.parametric.PET, 41 },                             { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -2, -3, -4, -5, -6, -6, -7, -7, -8 } },
    },
    [456] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Pet:DMG:+#%
        { { xi.augment.parametric.PET, 47 },          { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10 } },
        -- Pet:Damage taken +#%
        { { xi.augment.parametric.PET, 41 },          { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -2, -3, -4, -5, -6, -7, -8, -8, -9 } },
    },
    [457] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 },                    { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Pet:All Attr.+#
        { { xi.augment.parametric.PET, xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Pet:Damage taken +#%
        { { xi.augment.parametric.PET, 41 },                             { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -2, -3, -4, -5, -6, -6, -7, -7, -8 } },
    },
    [458] =
    {
        -- Pet:Attack+#
        { { xi.augment.parametric.PET, 19 },                             { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Attack+#
        { { 19 },                                                        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Pet:All Attr.+#
        { { xi.augment.parametric.PET, xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [459] =
    {
        -- Attack+#
        { { 19 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- STR+#
        { { 11 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10 } },
        -- DEX+#
        { { 12 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [460] =
    {
        -- Avatar:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.AVATAR, 100 },                            { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Avatar:All Attr.+#
        { { xi.augment.parametric.AVATAR, xi.augment.parametric.ALL_ATTR }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Avatar:Enmity+#
        { { xi.augment.parametric.AVATAR, 29 },                             { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [461] =
    {
        -- Automaton:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.AUTOMATON, 100 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Automaton:HP+#
        { { xi.augment.parametric.AUTOMATON, 9 },    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60 } },
        -- Automaton:Special attack damage+#%
        { { xi.augment.parametric.AUTOMATON, 1314 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [462] =
    {
        -- DEF+#
        { { 23 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Waltz" potency +#%
        { { 330 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10 } },
        -- "Mag. Def. Bns."+#
        { { 134 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [463] =
    {
        -- DEF+#
        { { 23 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Daken"+#
        { { 251 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10 } },
        -- Mag. Evasion+#
        { { 25 },  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 } },
    },
    [464] =
    {
        -- Accuracy+#
        { { 18 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Attack+#
        { { 19 },  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- "Store TP"+#
        { { 142 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [465] =
    {
        -- Weapon Skill Acc.+#
        { { 326 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Attack+#
        { { 19 },  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Skillchain dmg. +#%
        { { 332 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5 } },
    },
    [466] =
    {
        -- Rng. Acc.+#
        { { 20 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Rng. Atk.+#
        { { 21 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Enmity+#
        { { 29 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5 } },
    },
    [467] =
    {
        -- Mag. Acc.+#
        { { 24 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Enfb. mag. skill +#
        { { 290 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Enmity+#
        { { 29 },  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5 } },
    },
    [468] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- All Attr.+#
        { { xi.augment.parametric.ALL_ATTR },         { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5 } },
    },
    [469] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15 } },
        -- Evasion+# Mag. Evasion+#
        { { xi.augment.parametric.DEFENSE, 0x000C },  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 10, 10 } },
        -- Critical hit rate +#%
        { { 26 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5 } },
    },
    [470] =
    {
        -- Accuracy+# Rng. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0003 },   { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 21, 21, 22, 22, 23, 23, 24, 24, 25 } },
        -- Attack+# Rng. Atk.+#
        { { xi.augment.parametric.ATTACK, 0x0003 },     { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 } },
        -- STR DEX +#
        { { xi.augment.parametric.STAT_COMBO, 0x0003 }, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Enmity+#
        { { 29 },                                       { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10 } },
    },
    [471] =
    {
        -- Mag. Acc.+#
        { { 24 },  { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 20, 21, 21, 22, 22, 23, 23, 24, 24, 25 } },
        -- Magic Damage+#
        { { 362 }, { 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 } },
        -- INT+#
        { { 15 },  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 } },
        -- Enmity+#
        { { 29 },  { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10 } },
    },
    [472] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Double Attack"+#%
        { { 143 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7 } },
        -- Physical damage limit +#%
        { { 380 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6 } },
    },
    [473] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Double Attack"+#%
        { { 143 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 8 } },
        -- Physical damage limit +#%
        { { 380 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7 } },
    },
    [474] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Double Attack"+#%
        { { 143 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6 } },
        -- Physical damage limit +#%
        { { 380 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 5 } },
    },
    [475] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Double Attack"+#%
        { { 143 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7 } },
        -- Physical damage limit +#%
        { { 380 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6 } },
    },
    [476] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Double Attack"+#%
        { { 143 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6 } },
        -- Physical damage limit +#%
        { { 380 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 5 } },
    },
    [477] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7 } },
        -- "Triple Attack"+#%
        { { 144 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [478] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 8 } },
        -- "Triple Attack"+#%
        { { 144 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 5 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [479] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6 } },
        -- "Triple Attack"+#%
        { { 144 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [480] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7 } },
        -- "Triple Attack"+#%
        { { 144 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [481] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Store TP"+#
        { { 142 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6 } },
        -- "Triple Attack"+#%
        { { 144 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [482] =
    {
        -- Mag. Acc.+#
        { { 24 },                             { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 25, 26, 27, 28 } },
        -- "Blood Pact" damage +#
        { { 369 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 6, 7, 7, 8, 8, 8, 9, 9, 9, 10 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [483] =
    {
        -- Mag. Acc.+#
        { { 24 },                             { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32 } },
        -- "Blood Pact" damage +#
        { { 369 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [484] =
    {
        -- Mag. Acc.+#
        { { 24 },                             { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 29, 30 } },
        -- "Blood Pact" damage +#
        { { 369 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [485] =
    {
        -- Mag. Acc.+#
        { { 24 },                             { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 25, 26, 27, 28 } },
        -- "Blood Pact" damage +#
        { { 369 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 6, 7, 7, 8, 8, 8, 9, 9, 9, 10 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [486] =
    {
        -- Mag. Acc.+#
        { { 24 },                             { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Mag. Atk. Bns."+#
        { { 133 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 29, 30 } },
        -- "Blood Pact" damage +#
        { { 369 },                            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [487] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Triple Attack"+#%
        { { 144 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6 } },
        -- "Phalanx" received +#
        { { 368 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4 } },
    },
    [488] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Triple Attack"+#%
        { { 144 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 8 } },
        -- "Phalanx" received +#
        { { 368 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6 } },
    },
    [489] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Triple Attack"+#%
        { { 144 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7 } },
        -- "Phalanx" received +#
        { { 368 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 5 } },
    },
    [490] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Triple Attack"+#%
        { { 144 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6 } },
        -- "Phalanx" received +#
        { { 368 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4 } },
    },
    [491] =
    {
        -- Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0005 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- "Triple Attack"+#%
        { { 144 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7 } },
        -- "Phalanx" received +#
        { { 368 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 5 } },
    },
    [492] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Enmity+#
        { { 29 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5, -6, -6, -7, -7, -7, -8 } },
        -- Quadruple Attack +#%
        { { 354 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [493] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Enmity+#
        { { 29 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -2, -3, -4, -5, -6, -6, -7, -7, -8, -8, -8, -9, -9, -9, -10 } },
        -- Quadruple Attack +#%
        { { 354 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [494] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Enmity+#
        { { 29 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -2, -2, -3, -3, -4, -4, -5, -5, -6, -6, -7, -7, -8, -8, -9 } },
        -- Quadruple Attack +#%
        { { 354 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 5 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [495] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Enmity+#
        { { 29 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, -2, -2, -3, -3, -4, -4, -5, -5, -6, -6, -7, -7, -7, -8 } },
        -- Quadruple Attack +#%
        { { 354 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
    [496] =
    {
        -- Accuracy+# Rng. Acc.+# Mag. Acc.+#
        { { xi.augment.parametric.ACCURACY, 0x0007 }, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
        -- Enmity+#
        { { 29 },                                     { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -2, -2, -3, -3, -4, -4, -5, -5, -6, -6, -7, -7, -8, -8, -9 } },
        -- Quadruple Attack +#%
        { { 354 },                                    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 3, 4, 4, 4, 5 } },
        -- Pet:Accuracy+# Mag. Acc.+#
        { { xi.augment.parametric.PET, 100 },         { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30 } },
    },
}

-- Reinforcement point per rank for bundled and mezzotint augments
-- Bundled augments store TOTAL accumulated value. Mezzotint stores CURRENT RANK value.
-- Client uses below tables to calculate RP to next rank.
-- Sources:
--   - Bundled augments: ROM/118/114.DAT (mnc2, 48 bytes after header)
--   - Mezzotint: FFXiMain.dll signature C1 E8 02 83 E0 1F 33 D2 66 8B 14 45 ?? ?? ?? ?? 33 C0 66 8B 41 04 2B D0
xi.data.augments.rpCurves =
{
    [xi.augment.rpCurve.A] =
    {
        [ 0] =    30,
        [ 1] =    50,
        [ 2] =    80,
        [ 3] =   120,
        [ 4] =   170,
        [ 5] =   220,
        [ 6] =   280,
        [ 7] =   340,
        [ 8] =   410,
        [ 9] =   480,
        [10] =   560,
        [11] =   650,
        [12] =   750,
        [13] =   860,
        [14] =   980,
        [15] =  1110,
        [16] =  1250,
        [17] =  1410,
        [18] =  1580,
        [19] =  1760,
        [20] =  1960,
        [21] =  2170,
        [22] =  2400,
        [23] =  2650,
        [24] =  2910,
        [25] =  3180,
        [26] =  3460,
        [27] =  3760,
        [28] =  4070,
        [29] =  4400,
        [30] =  4750,
    },

    [xi.augment.rpCurve.B] =
    {
        [ 0] =   750,
        [ 1] =  1600,
        [ 2] =  2500,
        [ 3] =  3400,
        [ 4] =  4400,
        [ 5] =  5400,
        [ 6] =  6500,
        [ 7] =  7600,
        [ 8] =  8800,
        [ 9] = 10000,
        [10] = 11300,
        [11] = 12700,
        [12] = 14100,
        [13] = 15600,
        [14] = 17200,
        [15] = 18800,
        [16] = 20500,
        [17] = 22300,
        [18] = 24200,
        [19] = 26200,
        [20] = 28300,
        [21] = 30500,
        [22] = 32800,
        [23] = 35200,
        [24] = 37700,
        [25] = 40400,
        [26] = 43200,
        [27] = 46100,
        [28] = 49200,
        [29] = 52400,
        [30] = 55800,
    },
    [xi.augment.rpCurve.MEZZOTINT] = -- Effectively a copy of curve A, duplicated for clarity.
    {
        [ 0] =   30,
        [ 1] =   50,
        [ 2] =   80,
        [ 3] =  120,
        [ 4] =  170,
        [ 5] =  220,
        [ 6] =  280,
        [ 7] =  340,
        [ 8] =  410,
        [ 9] =  480,
        [10] =  560,
        [11] =  650,
        [12] =  750,
        [13] =  860,
        [14] =  980,
    },
}
