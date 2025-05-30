locals {
  directors = [
    {
      backends = [
        "backend",
        "backend-2",
      ]
      comment = "This is a sample director"
      name    = "Sample Director"
      quorum  = 75
      retries = 5
      shield  = ""
      type    = 1 # 1 for round-robin, 2 for random, 3 for hash, 4 for client
    },
  ]
}
