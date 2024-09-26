from locust import HttpUser, TaskSet, task, between

class UserBehavior(TaskSet):
    def on_start(self):
        """Login user at the start of each test"""
        self.login()

    def login(self):
        """Simulate user login"""
        response = self.client.post("/api/login/", json={"username": "testuser", "password": "testpass"})
        self.token = response.json().get('token')
        self.headers = {'Authorization': f'Bearer {self.token}'}

    @task(1)
    def ajouter_au_panier(self):
        """Simulate adding a product to the cart"""
        self.client.post("/ajouter_au_panier/1/", headers=self.headers)

    @task(2)
    def creer_commande(self):
        """Simulate creating a new order"""
        self.client.post("/creer_commande/", headers=self.headers, json={
            'statut': 'pending',
            'total': 100,
        })

    @task(3)
    def checkout(self):
        """Simulate the checkout process"""
        self.client.post("/checkout/1/", headers=self.headers)

    @task(4)
    def suivre_commande(self):
        """Simulate following an order"""
        self.client.get("/suivre/1/", headers=self.headers)

    @task(5)
    def annuler_commande(self):
        """Simulate cancelling an order"""
        self.client.post("/annuler_commande/1/", headers=self.headers)

class WebsiteUser(HttpUser):
    tasks = [UserBehavior]
    wait_time = between(1, 3)
