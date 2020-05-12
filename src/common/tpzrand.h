#include <random>

class tpzrand
{
public:
    static std::mt19937& mt()
    {
        static thread_local std::mt19937 e{};
        return e;
    }

    static void seed(void)
    {
        std::array<uint32_t, std::mt19937::state_size> seed_data;
        std::random_device rd;
        std::generate(seed_data.begin(), seed_data.end(), std::ref(rd));
        std::seed_seq seq(seed_data.begin(), seed_data.end());
        mt().seed(seq);
    }

    /*Generates a random number in the half-open interval [min, max)
    @param min
    @param max
    @returns result
    */
    template <typename T>
    static inline typename std::enable_if<std::is_integral<T>::value, T>::type
        GetRandomNumber(T min, T max)
    {
        if (min == max - 1 || max == min)
        {
            return min;
        }
        std::uniform_int_distribution<T> dist(min, max - 1);
        return dist(mt());
    }

    template<typename T>
    static inline typename std::enable_if<std::is_floating_point<T>::value, T>::type
        GetRandomNumber(T min, T max)
    {
        if (min == max)
        {
            return min;
        }
        std::uniform_real_distribution<T> dist(min, max);
        return dist(mt());
    }

    /*Generates a random number in the half-open interval [0, max)
    @param min
    @param max
    @returns result
    */
    template <typename T>
    static inline T GetRandomNumber(T max)
    {
        return GetRandomNumber<T>(0, max);
    }
};
