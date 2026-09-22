// Phoenix fishing regression tests, linked only into xi_test.
// These exercise the current calculations, not retail capture expectations.

#include "map/utils/fishingutils.h"

#include <catch2/catch_test_macros.hpp>

#include <cmath>
#include <cstdlib>

TEST_CASE("Fishing small-fish losses depend on fish level, not angler skill or rank", "[phoenix][fishing]")
{
    auto rod     = rod_t{};
    rod.rodID    = COMPOSITE;
    rod.sizeType = FISHINGSIZETYPE_LARGE;
    rod.minRank  = 1;

    for (const auto skill : { 20, 100 })
    {
        for (const auto rank : { 0, 10 })
        {
            CAPTURE(skill, rank);
            const auto result = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_SMALLFISH, skill, 20, FISHINGSIZETYPE_SMALL, false, rank, &rod);
            CHECK(result.failReason == FISHINGFAILTYPE_LOST_TOOSMALL);
            CHECK(result.chance == 36);
        }
    }
}

TEST_CASE("Fishing small-fish loss chance stops at ninety percent", "[phoenix][fishing]")
{
    auto rod     = rod_t{};
    rod.sizeType = FISHINGSIZETYPE_LARGE;

    for (const auto level : { 50, 100 })
    {
        CAPTURE(level);
        const auto result = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_SMALLFISH, 100, level, FISHINGSIZETYPE_SMALL, false, 0, &rod);
        CHECK(result.failReason == FISHINGFAILTYPE_LOST_TOOSMALL);
        CHECK(result.chance == 90);
    }
}

TEST_CASE("Fishing legendary rods bypass size losses", "[phoenix][fishing]")
{
    auto rod      = rod_t{};
    rod.legendary = true;
    rod.sizeType  = FISHINGSIZETYPE_LARGE;

    const auto result = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_SMALLFISH, 100, 50, FISHINGSIZETYPE_SMALL, false, 0, &rod);
    CHECK(result.failReason == FISHINGFAILTYPE_NONE);
    CHECK(result.chance == 0);
}

TEST_CASE("Fishing skill losses start beyond seven levels and become certain at fifty", "[phoenix][fishing]")
{
    auto rod = rod_t{};

    struct SkillCase
    {
        uint8 maxSkill;
        uint8 chance;
        uint8 reason;
    };

    const SkillCase cases[] = {
        { 27, 0, FISHINGFAILTYPE_NONE },
        { 28, 0, FISHINGFAILTYPE_NONE },
        { 29, 1, FISHINGFAILTYPE_LOST_LOWSKILL },
        { 69, 33, FISHINGFAILTYPE_LOST_LOWSKILL },
        { 70, 100, FISHINGFAILTYPE_LOST_LOWSKILL },
        { 71, 100, FISHINGFAILTYPE_LOST_LOWSKILL },
    };

    for (const auto& entry : cases)
    {
        CAPTURE(entry.maxSkill);
        const auto result = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_SMALLFISH, 20, entry.maxSkill, FISHINGSIZETYPE_SMALL, false, 0, &rod);
        CHECK(result.failReason == entry.reason);
        CHECK(result.chance == entry.chance);
    }
}

TEST_CASE("Fishing guaranteed skill loss takes precedence over rod size loss", "[phoenix][fishing]")
{
    auto rod     = rod_t{};
    rod.rodID    = SINGLE_HOOK;
    rod.sizeType = FISHINGSIZETYPE_LARGE;

    const auto result = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_SMALLFISH, 0, 50, FISHINGSIZETYPE_SMALL, false, 0, &rod);
    CHECK(result.failReason == FISHINGFAILTYPE_LOST_LOWSKILL);
    CHECK(result.chance == 100);
}

TEST_CASE("Fishing items and monsters do not incur low-skill losses", "[phoenix][fishing]")
{
    auto rod = rod_t{};

    for (const auto type : { FISHINGCATCHTYPE_ITEM, FISHINGCATCHTYPE_MOB })
    {
        CAPTURE(type);
        const auto result = fishingutils::CalculateLoseChance(type, 0, 100, FISHINGSIZETYPE_SMALL, false, 0, &rod);
        CHECK(result.failReason == FISHINGFAILTYPE_NONE);
        CHECK(result.chance == 0);
    }
}

TEST_CASE("Fishing oversized catches have a fifty percent size-loss ceiling", "[phoenix][fishing]")
{
    auto rod    = rod_t{};
    rod.maxRank = 10;

    const auto result = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_BIGFISH, 20, 40, FISHINGSIZETYPE_LARGE, false, 11, &rod);
    CHECK(result.failReason == FISHINGFAILTYPE_LOST_TOOBIG);
    CHECK(result.chance == 50);
}

TEST_CASE("Fishing line snaps begin above rod durability and cap at fifty-five", "[phoenix][fishing]")
{
    auto rod    = rod_t{};
    rod.maxRank = 10;

    for (const auto rank : { 10, 11, 12, 13 })
    {
        CAPTURE(rank);
        const auto  result    = fishingutils::CalculateSnapChance(FISHINGCATCHTYPE_SMALLFISH, 0, 10, FISHINGSIZETYPE_SMALL, false, rank, &rod);
        const uint8 chances[] = { 0, 19, 38, 55 };
        CHECK(result.chance == chances[rank - 10]);
        if (rank == 10)
        {
            CHECK(result.failReason == FISHINGFAILTYPE_NONE);
        }
        else
        {
            CHECK(result.failReason == FISHINGFAILTYPE_LINESNAP);
        }
    }
}

TEST_CASE("Fishing unbreakable rods cannot break on legendary oversized fish", "[phoenix][fishing]")
{
    auto rod = rod_t{};

    const auto result = fishingutils::CalculateBreakChance(FISHINGCATCHTYPE_BIGFISH, 0, 100, FISHINGSIZETYPE_LARGE, true, 100, &rod);
    CHECK(result.failReason == FISHINGFAILTYPE_NONE);
    CHECK(result.chance == 0);
}

TEST_CASE("Fishing rod breaks begin above durability and cap at twenty", "[phoenix][fishing]")
{
    auto rod      = rod_t{};
    rod.breakable = true;
    rod.maxRank   = 10;

    const auto safe = fishingutils::CalculateBreakChance(FISHINGCATCHTYPE_SMALLFISH, 0, 10, FISHINGSIZETYPE_SMALL, false, 10, &rod);
    CHECK(safe.failReason == FISHINGFAILTYPE_NONE);
    CHECK(safe.chance == 0);

    const auto weak = fishingutils::CalculateBreakChance(FISHINGCATCHTYPE_SMALLFISH, 0, 10, FISHINGSIZETYPE_SMALL, false, 11, &rod);
    CHECK(weak.failReason == FISHINGFAILTYPE_RODBREAK);
    CHECK(weak.chance == 10);

    const auto capped = fishingutils::CalculateBreakChance(FISHINGCATCHTYPE_SMALLFISH, 0, 10, FISHINGSIZETYPE_SMALL, false, 100, &rod);
    CHECK(capped.failReason == FISHINGFAILTYPE_RODBREAK);
    CHECK(capped.chance == 20);
}

TEST_CASE("Fishing legendary attack bonuses also increase wrong-arrow healing", "[phoenix][fishing]")
{
    auto rod         = rod_t{};
    rod.fishAttack   = 100;
    rod.lgdBonusAtk  = 50;
    rod.fishRecovery = 50;

    CHECK(fishingutils::CalculateAttack(fishingutils::Legendary::No, 20, &rod) == 400);
    CHECK(fishingutils::CalculateAttack(fishingutils::Legendary::Yes, 20, &rod) == 600);
    CHECK(fishingutils::CalculateHeal(fishingutils::Legendary::No, 20, &rod) == 100);
    CHECK(fishingutils::CalculateHeal(fishingutils::Legendary::Yes, 20, &rod) == 150);
}

TEST_CASE("Fishing area segments intersect at crossings, endpoints and overlaps", "[phoenix][fishing]")
{
    CHECK(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 10 }, { 0, 0, 10 }, { 10, 0, 0 }));
    CHECK(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 0 }, { 10, 0, 0 }, { 20, 0, 0 }));
    CHECK(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 0 }, { 5, 0, 0 }, { 15, 0, 0 }));
    CHECK_FALSE(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 0 }, { 11, 0, 0 }, { 20, 0, 0 }));
    CHECK_FALSE(fishingutils::doIntersect({ 0, 0, 0 }, { 10, 0, 0 }, { 0, 0, 1 }, { 10, 0, 1 }));
}

TEST_CASE("Fishing polygon boundaries include edges and enforce height", "[phoenix][fishing]")
{
    areavector_t polygon[] = { { 0, 0, 0 }, { 10, 0, 0 }, { 10, 0, 10 }, { 0, 0, 10 } };

    CHECK(fishingutils::isInsidePoly(polygon, 4, { 5, 0, 5 }, 0, 4));
    CHECK(fishingutils::isInsidePoly(polygon, 4, { 0, 0, 5 }, 0, 4));
    CHECK(fishingutils::isInsidePoly(polygon, 4, { 5, 2, 5 }, 0, 4));
    CHECK(fishingutils::isInsidePoly(polygon, 4, { 5, -2, 5 }, 0, 4));
    CHECK_FALSE(fishingutils::isInsidePoly(polygon, 4, { 11, 0, 5 }, 0, 4));
    CHECK_FALSE(fishingutils::isInsidePoly(polygon, 4, { 5, 3, 5 }, 0, 4));
    CHECK_FALSE(fishingutils::isInsidePoly(polygon, 4, { 5, -3, 5 }, 0, 4));
    CHECK_FALSE(fishingutils::isInsidePoly(polygon, 2, { 5, 0, 5 }, 0, 4));
}

TEST_CASE("Fishing cylinders include the radius and reject points beyond it", "[phoenix][fishing]")
{
    const auto center = areavector_t{ 10, 20, 30 };

    CHECK(fishingutils::isInsideCylinder(center, { 10, 20, 30 }, 5, 4));
    CHECK(fishingutils::isInsideCylinder(center, { 13, 20, 34 }, 5, 4));
    CHECK(fishingutils::isInsideCylinder(center, { 7, 20, 26 }, 5, 4));
    CHECK(fishingutils::isInsideCylinder(center, { 10, 22, 30 }, 5, 4));
    CHECK(fishingutils::isInsideCylinder(center, { 10, 18, 30 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 14, 20, 34 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 16, 20, 30 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 10, 20, 36 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 10, 23, 30 }, 5, 4));
    CHECK_FALSE(fishingutils::isInsideCylinder(center, { 10, 17, 30 }, 5, 4));
}

TEST_CASE("Fishing a Nebimonite from the Selbina ship warns without promising", "[phoenix][fishing][simulation]")
{
    // The Tarutaru rod and Nebimonite as sql/fishing_rod.sql and sql/fishing_fish.sql hold them.
    // Zone 220 draws on fishing group 136, where Nebimonite is the only entry that takes a
    // Ball of Crayfish Paste, so every fish that bites there on that bait is this one.
    auto rod      = rod_t{};
    rod.rodID     = TARUTARU;
    rod.sizeType  = FISHINGSIZETYPE_SMALL;
    rod.minRank   = 1;
    rod.maxRank   = 9;
    rod.breakable = true;
    rod.legendary = false;

    constexpr uint8 fishLevel   = 27;
    constexpr uint8 fishRanking = 10;
    constexpr int   reels       = 100000;

    for (const auto anglerSkill : { 0, 30 })
    {
        CAPTURE(anglerSkill);

        const auto lose  = fishingutils::CalculateLoseChance(FISHINGCATCHTYPE_SMALLFISH, anglerSkill, fishLevel, FISHINGSIZETYPE_SMALL, false, fishRanking, &rod);
        const auto snap  = fishingutils::CalculateSnapChance(FISHINGCATCHTYPE_SMALLFISH, anglerSkill, fishLevel, FISHINGSIZETYPE_SMALL, false, fishRanking, &rod);
        const auto crack = fishingutils::CalculateBreakChance(FISHINGCATCHTYPE_SMALLFISH, anglerSkill, fishLevel, FISHINGSIZETYPE_SMALL, false, fishRanking, &rod);

        // Skill no longer stiffens the line, so the rank gap bites at thirty exactly as it does at zero
        CHECK(snap.chance == 19);
        CHECK(crack.chance == 10);

        const double loseRate  = lose.chance / 100.0;
        const double snapRate  = (1.0 - loseRate) * (snap.chance / 100.0);
        const double crackRate = (1.0 - loseRate) * (1.0 - snap.chance / 100.0) * (crack.chance / 100.0);
        const double landRate  = 1.0 - loseRate - snapRate - crackRate;

        int good     = 0;
        int bad      = 0;
        int terrible = 0;
        int doubt    = 0;

        int goodLanded    = 0;
        int badSnapped    = 0;
        int terribleBroke = 0;
        int doubtLost     = 0;

        int landed    = 0;
        int snapped   = 0;
        int cracked   = 0;
        int lostSkill = 0;
        int quietBreak = 0;

        for (int reel = 0; reel < reels; ++reel)
        {
            auto response = fishresponse_t{};

            const auto sense = fishingutils::CalculateFishSense(nullptr, &response, anglerSkill, FISHINGCATCHTYPE_SMALLFISH,
                                                                FISHINGSIZETYPE_SMALL, fishLevel, fishingutils::Legendary::No, 1, 1, fishRanking, &rod);

            auto* outcome = fishingutils::ReelCheck(nullptr, &response, &rod);

            if (sense == FISHINGSENSETYPE_TERRIBLE)
            {
                ++terrible;
                terribleBroke += outcome->rodbreak ? 1 : 0;
            }
            else if (sense == FISHINGSENSETYPE_BAD)
            {
                ++bad;
                badSnapped += outcome->linebreak ? 1 : 0;
            }
            else if (sense == FISHINGSENSETYPE_GOOD)
            {
                ++good;
                goodLanded += outcome->caught ? 1 : 0;
            }
            else
            {
                ++doubt;
                doubtLost += outcome->failReason == FISHINGFAILTYPE_LOST_LOWSKILL ? 1 : 0;
            }

            // A fish may still prove too small under a good feeling, but the line and the rod
            // are never taken from an angler who was told nothing was wrong
            if ((outcome->linebreak || outcome->rodbreak) && sense == FISHINGSENSETYPE_GOOD)
            {
                ++quietBreak;
            }

            if (outcome->caught)
            {
                ++landed;
            }
            else if (outcome->linebreak)
            {
                ++snapped;
            }
            else if (outcome->rodbreak)
            {
                ++cracked;
            }
            else
            {
                ++lostSkill;
            }

            destroy(outcome);
        }

        WARN("Nebimonite, Tarutaru Fishing Rod, skill " << anglerSkill << ", over " << reels << " reels"
             << "\n  rolled chances    loss " << static_cast<int>(lose.chance)
             << ", snap " << static_cast<int>(snap.chance)
             << ", break " << static_cast<int>(crack.chance)
             << "\n  good      shown " << good << ", landed " << goodLanded
             << "\n  unsure    shown " << doubt << ", lost to skill " << doubtLost
             << "\n  bad       shown " << bad << ", line snapped " << badSnapped
             << "\n  terrible  shown " << terrible << ", rod broke " << terribleBroke
             << "\n  outcomes  landed " << landed << " (expected " << static_cast<int>(landRate * reels) << ")"
             << ", snapped " << snapped << " (" << static_cast<int>(snapRate * reels) << ")"
             << ", broke " << cracked << " (" << static_cast<int>(crackRate * reels) << ")"
             << ", lost to skill " << lostSkill << " (" << static_cast<int>(loseRate * reels) << ")");

        // A warning is a strong hint and never a promise, so the angler who drops every one of
        // them throws away fish, and the angler who fights them all still lands most
        CHECK(badSnapped * 100 > bad * 60);
        CHECK(badSnapped * 100 < bad * 90);
        CHECK(terribleBroke * 100 > terrible * 55);
        CHECK(terribleBroke * 100 < terrible * 85);

        // Doubt reports the gap in skill rather than this reel, so it is wrong far more often than right
        if (lose.chance > 0)
        {
            CHECK(doubtLost * 100 < doubt * 40);
        }

        // Neither the line nor the rod goes without warning
        CHECK(quietBreak == 0);

        // The rod is called into question on a visible share of bites
        CHECK(terrible > reels / 100);

        // A one point band runs to many standard deviations at this sample size, so none of these can flake
        CHECK(std::abs(landed - static_cast<int>(landRate * reels)) < reels / 100);
        CHECK(std::abs(snapped - static_cast<int>(snapRate * reels)) < reels / 100);
        CHECK(std::abs(cracked - static_cast<int>(crackRate * reels)) < reels / 100);
        CHECK(std::abs(lostSkill - static_cast<int>(loseRate * reels)) < reels / 100);
    }
}
