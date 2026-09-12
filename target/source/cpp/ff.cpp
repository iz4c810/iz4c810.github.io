#include <iostream>
#include <string>
#include <thread>
#include <chrono>
#include <sys/sysinfo.h>

struct LiveMetrics {
    double used_ram;
    double total_ram;
    unsigned long uptime;
};

LiveMetrics sample_hardware() {
    LiveMetrics metrics{0, 0, 0};
    struct sysinfo info;

    if (sysinfo(&info) == 0) {
        double gb = 1024.0 * 1024.0;
        metrics.total_ram = (info.totalram * info.mem_unit) / gb;
        metrics.used_ram = ((info.totalram - info.freeram) * info.mem_unit) / gb;
        metrics.uptime = info.uptime;
    }
    return metrics;

}

int main() {
    // 1. hide terminal cursor so no blinking during updates
    std::cout << "\033[?25l";

    // Clear the screen completely, just once at startup
    std::cout << "\033[2J";

    // ANSI Style Strings
    std::string cyan = "\033[1;36m";
    std::string green = "\033[1;32m";
    std::string reset = "\033[0m";

    bool running = true;
    while (running) {
        // 2. Fetch Live State
        LiveMetrics data = sample_hardware();

        // 3. Cursor goes to 0,0 instead of clearing
        std::cout << "\033[H";

        // 4. Rendering the interface
        std::cout << cyan  << "   /\\_/\\    " << green << "LIVE SYSTEM MONITER\n";
        std::cout << cyan  << "  ( o.o )   " << green << "Uptime:   " << reset << data.uptime << " seconds\n";
        std::cout << cyan  << "   > ^ <    " << green << "Live Ram:   " << reset << data.used_ram << " GB / " << data.total_ram <<" GB\n";

        // 5. force the buffer to display immediately
        std::cout << std::flush;

        // 6. refresh rate controller
        std::this_thread::sleep_for(std::chrono::milliseconds(500));
    }

    // Restore the cursor when the loop exits
    std::cout << "\033[?25h";
    return 0;
}
