from prometheus_client import start_http_server, Gauge
import time

# Création de métriques personnalisées
REQUEST_LATENCY = Gauge('request_latency_seconds', 'Latency of requests in seconds')

def measure_request_latency():
    """ Simuler la mesure de latence des requêtes """
    while True:
        start_time = time.time()
        # Simuler une opération
        time.sleep(1)
        latency = time.time() - start_time
        REQUEST_LATENCY.set(latency)
        time.sleep(10)

if __name__ == '__main__':
    start_http_server(8000)  # Expose les métriques sur le port 8000
    measure_request_latency()
