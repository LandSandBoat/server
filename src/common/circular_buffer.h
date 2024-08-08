// https://gist.github.com/edwintcloud/d547a4f9ccaf7245b06f0e8782acefaa

#pragma once

#include <memory>
#include <mutex>

template <class T>
class CircularBuffer
{
private:
    std::unique_ptr<T[]> buffer;

    std::size_t head = 0;
    std::size_t tail = 0;
    std::size_t max_size;
    bool        full = false;
    T           empty_item;

    std::recursive_mutex mutex;

public:
    CircularBuffer(std::size_t max_size)
    : buffer(std::unique_ptr<T[]>(new T[max_size]))
    , max_size(max_size){};

    void enqueue(T const& item)
    {
        std::lock_guard lock(mutex);

        buffer[tail] = item;

        if (full)
        {
            head = (head + 1) % max_size;
        }

        tail = (tail + 1) % max_size;

        full = tail == head;
    }

    T dequeue()
    {
        std::lock_guard lock(mutex);

        if (is_empty())
        {
            throw std::runtime_error("buffer is empty");
        }

        T item = buffer[head];

        buffer[head] = empty_item;

        head = (head + 1) % max_size;

        full = false;

        return item;
    }

    T front()
    {
        std::lock_guard lock(mutex);

        if (is_empty())
        {
            throw std::runtime_error("buffer is empty");
        }

        return buffer[head];
    }

    bool is_empty()
    {
        std::lock_guard lock(mutex);

        return (!full && (head == tail));
    }

    bool is_full()
    {
        std::lock_guard lock(mutex);

        return full;
    }

    std::size_t size()
    {
        std::lock_guard lock(mutex);

        if (full)
        {
            return max_size;
        }

        if (tail >= head)
        {
            return tail - head;
        }

        return max_size - head + tail;
    }
};
