// https://gist.github.com/edwintcloud/d547a4f9ccaf7245b06f0e8782acefaa

#pragma once

#include <memory>

template <class T>
class CircularBuffer
{
private:
    std::unique_ptr<T[]> buffer;

    std::size_t head = 0;
    std::size_t tail = 0;
    std::size_t max_size;
    T           empty_item;

public:
    CircularBuffer<T>(std::size_t max_size)
    : buffer(std::unique_ptr<T[]>(new T[max_size]))
    , max_size(max_size){};

    void enqueue(T item)
    {
        if (is_full())
        {
            throw std::runtime_error("buffer is full");
        }

        buffer[tail] = item;

        tail = (tail + 1) % max_size;
    }

    T dequeue()
    {
        if (is_empty())
        {
            throw std::runtime_error("buffer is empty");
        }

        T item = buffer[head];

        T empty;
        buffer[head] = empty_item;

        head = (head + 1) % max_size;

        return item;
    }

    T front()
    {
        return buffer[head];
    }

    bool is_empty()
    {
        return head == tail;
    }

    bool is_full()
    {
        return tail == (head - 1) % max_size;
    }

    std::size_t size()
    {
        if (tail >= head)
        {
            return tail - head;
        }

        return max_size - head - tail;
    }
};
